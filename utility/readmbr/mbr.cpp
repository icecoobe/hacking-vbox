
#include <windows.h>
#include <stdio.h>
#include <conio.h>

int main(int argc, char* argv[])
{
  printf("�����ⰴ���鿴MBR��Ϣ -- icecoobe\n");
  getch();
  printf("-------------------------------------------------\n");

  FILE* fd = fopen("\\\\.\\PHYSICALDRIVE0", "rb+");
  if (fd == NULL)
  {
        printf("��ȡ����!\n");
        getch();
        return 0;
  }

  unsigned char buffer[512];
  fread(buffer, 512, 1, fd);

  for (int i = 0; i < 512; i++)
  {
      printf("%02X ", buffer[i]);
      if ((i+1) % 16 == 0)
         printf("\n");
  }

  fclose(fd);

  printf("-------------------------------------------------\n");
  printf("�����ⰴ����������\n");
  getch();
        return 0;
}
 
