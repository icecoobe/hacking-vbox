
#define STRICT	// �ϸ����ͼ��
#define WIN32_LEAN_AND_MEAN // �޳�����ʹ�õ�ͷ�ļ�

#ifdef __cplusplus
# define CINTERFACE // COMͷ�ļ������ֶ��巽ʽc | c++
#endif // __cplusplus

#ifdef _MSC_VER // Microsoft Visual C++ Compiler
# define _CRT_SECURE_NO_WARNINGS
#endif // _MSC_VER

#include <windows.h>

/* C run time library headers */
#include <io.h>
#include <stdlib.h>
#include <stdio.h>
#include <conio.h>

/* COM headers (requires shell32.lib, ole32.lib, uuid.lib) */
#include <objbase.h>
#include <shlobj.h>

static HRESULT 
CreateShortCut(LPSTR pszTargetfile, LPSTR pszTargetargs,
              LPSTR pszLinkfile, LPSTR pszDescription, 
              int iShowmode, LPSTR pszCurdir,
              LPSTR pszIconfile, int iIconindex);

int main(int argc, char **argv)
{
    printf("-------------------------------------------------------------\n");
    printf("ΪVirtualBox�����������ݷ�ʽ\n");
	printf("1.��Ҫָ��Ŀ��Ŀ¼�����������!\n");
	printf("2.������������ִ�Сд!\n");
    printf("\nUsage:\n\tCreateShortcutForVM TargetDirectoryPath VMName \n");
    printf("-------------------------------------------------------------\n\n");

	// �����������ĸ�����С��3�����Ϸ�
    if (argc < 3)
    {
        printf("������������!\n");
        printf("Usage:\n");
        printf("\tCreateShortcutForVM TargetDirectoryPath VMName\n");
        printf("\n��������˳� ...\n");
		_getch();
        return 0;
    }
    
	if ((_access(argv[1], 0 )) == -1)
	{
		printf("%s doesnt exist!\n", argv[1]);
		printf("\n��������˳� ...\n");
		_getch();
		return 0;
	}

    HRESULT hRes;                      /* result of calling COM functions */
    hRes = CoInitialize(NULL);

	// virtualbox��Ŀ¼
    char vboxdir[MAX_PATH];
    sprintf(vboxdir, "%s", getenv("VBOX_MSI_INSTALL_PATH"));

	// VirtualBox.exe�ļ�·��
    char vboxpath[MAX_PATH];
    sprintf(vboxpath, "%svirtualbox.exe", vboxdir);

	// ��ݷ�ʽ��·��
	char shortcutpath[MAX_PATH];
	sprintf(shortcutpath, "%s\\%s.lnk", argv[1], argv[2]);

	// ��ݷ�ʽ�е������в���
	// "C:\Program Files\Oracle\VirtualBox\VirtualBox.exe" --comment "DemoVM" --startvm "14258dcc-c2cd-4f5f-b758-cd2ab1c100aa"
	char szArguments[1024];
	sprintf(szArguments, " --comment \"%s\" --startvm \"%s\"", argv[2], argv[2]); 
	
	// ��ݷ�ʽ�еı�ע
	char szDesc[1024];
	sprintf(szDesc, "Starts the VirtualBox machine %s", argv[2]);

    if (SUCCEEDED(hRes))
    {
      hRes = CreateShortCut(vboxpath,
                            szArguments,		/* Target arguments */
                            shortcutpath,		/* Short-cut filename */
                            szDesc,				/* Short-cut description */
                            SW_SHOW,			/* Showmode constant */
                            vboxdir,			/* Working directory for linked file */
                            vboxpath,			/* Icon file shown for the link */
                            0);					/* Index of icon in the file */
	  if (SUCCEEDED(hRes))
	  {
		  printf("Everything's OK!\n");
	  }
	  else
	  {
		  printf("����һЩ����,���=%X\n", hRes);
		  printf("\n��������˳� ...\n");
		  _getch();
	  }
     }
    /* call CoUninitialize() and exit the program. */
    CoUninitialize();

	return 0;
}

static HRESULT CreateShortCut(LPSTR pszTargetfile, LPSTR pszTargetargs,
                              LPSTR pszLinkfile, LPSTR pszDescription, 
                              int iShowmode, LPSTR pszCurdir,
                              LPSTR pszIconfile, int iIconindex)
{
  HRESULT       hRes = E_INVALIDARG;            /* Returned COM result code */
  IShellLink*   pShellLink = NULL;				/* IShellLink object pointer */
  IPersistFile* pPersistFile = NULL;			/* IPersistFile object pointer */
  WORD          wszLinkfile[MAX_PATH];			/* pszLinkfile as Unicode string */
  int           iWideCharsWritten = 0;			/* Number of wide characters written */

  if (
       (pszTargetfile != NULL) && (strlen(pszTargetfile) > 0) &&
       (pszTargetargs != NULL) &&
       (pszLinkfile != NULL) && (strlen(pszLinkfile) > 0) &&
       (pszDescription != NULL) && 
       (iShowmode >= 0) &&
       (pszCurdir != NULL) && 
       (pszIconfile != NULL) && 
       (iIconindex >= 0)
     )
  {
    hRes = CoCreateInstance(CLSID_ShellLink,			/* pre-defined CLSID of the IShellLink object */
                            NULL,						/* pointer to parent interface if part of aggregate */
                            CLSCTX_INPROC_SERVER,		/* caller and called code are in same process */
                            IID_IShellLink,				/* pre-defined interface of the IShellLink object */
                            (LPVOID*)&pShellLink);      /* Returns a pointer to the IShellLink object */

    if (SUCCEEDED(hRes))
    {
      /* Set the fields in the IShellLink object */
      hRes = pShellLink->lpVtbl->SetPath(pShellLink, pszTargetfile);
      hRes = pShellLink->lpVtbl->SetArguments(pShellLink, pszTargetargs);
      if (strlen(pszDescription) > 0)
      {
        hRes = pShellLink->lpVtbl->SetDescription(pShellLink, pszDescription);
      }
      if (iShowmode > 0)
      {
        hRes = pShellLink->lpVtbl->SetShowCmd(pShellLink, iShowmode);
      }
      if (strlen(pszCurdir) > 0)
      {
        hRes = pShellLink->lpVtbl->SetWorkingDirectory(pShellLink, pszCurdir);
      }
      if (strlen(pszIconfile) > 0 && iIconindex >= 0)
      {
        hRes = pShellLink->lpVtbl->SetIconLocation(pShellLink, pszIconfile, iIconindex);
      }
      /* Use the IPersistFile object to save the shell link */
      hRes = pShellLink->lpVtbl->QueryInterface(pShellLink,        /* existing IShellLink object */
                                                IID_IPersistFile, /* pre-defined interface of the IPersistFile object */
                                                (void **)&pPersistFile);    /* returns a pointer to the IPersistFile object */
      if (SUCCEEDED(hRes))
      {
        iWideCharsWritten = MultiByteToWideChar(CP_ACP, 0, pszLinkfile, -1, (LPWSTR)wszLinkfile, MAX_PATH);
        hRes = pPersistFile->lpVtbl->Save(pPersistFile, (LPWSTR)wszLinkfile, TRUE);
        pPersistFile->lpVtbl->Release(pPersistFile);
      }
      pShellLink->lpVtbl->Release(pShellLink);
    }
  }
  return (hRes);
}