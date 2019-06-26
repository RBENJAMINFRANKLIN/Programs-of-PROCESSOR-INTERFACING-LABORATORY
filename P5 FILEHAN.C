#include<stdio.h>
#include<dos.h>
union REGS reg1,reg2;
struct SREGS   segreg;
void main()
{
 char dirname[100];
 int ch,h1,h2,h3 ;
 char srcfile[10]; char destfile[10];

 clrscr();

 printf("\n 1. Create a Directory \n 2. Delete a File \n 3. Copy The File\n 4. Exit \n");
 scanf("%d",&ch);
do
{
switch(ch)
{
 case 1:
 printf("\n Enter THE NAME OF THE DIRECTORY...\n");
 scanf("%s",dirname);
 reg1.h.ah = 0x39;
 reg1.x.dx=FP_OFF(dirname);
 intdos(&reg1,&reg2) ;

 //check to create
 if(reg2.x.cflag==0)
  {

	printf("\n Successfull.... \n");
  }
 else if(reg2.x.ax==3)
  {
	printf("\n Path Not Found.... \n");
  }
else if(reg2.x.ax==5)
  {
	printf("\n Access Denied....  \n");
  }
else
	printf("Some Other Problem... ");
break;

case 2:
	printf("\n DELETING ..... \n");
	printf("\n ENTER THE FILE NAME TO BE DELETED ..... \n");
	 scanf("%s",srcfile);
	 reg1.h.ah = 0x41;
	 reg1.x.dx=FP_OFF(srcfile);
	 int86(0x21,&reg1,&reg2) ;

	//check to delete

	if(reg2.x.cflag==0)
	{
	   printf("\n Successfull.... \n");
	}
	else if(reg2.x.ax==2)
	{
		printf("\n File Not Found.... \n");
	}
	else if(reg2.x.ax==3)
	{
	  printf("\n Path Not Found.... \n");
	}
	else if(reg2.x.ax==5)
	{
	  printf("\n Access Denied....  \n");
	}
	else
	  printf("Some Other Problem... ");
	break;
case 3 :
       printf("Enter source file to be copied:- ");
scanf("%s",srcfile);
	reg1.h.ah=0X3D;  // OPEN THE FILE WITH HANDLE
	reg1.x.dx=FP_OFF(srcfile);
	segreg.ds=FP_SEG(srcfile);
	reg1.h.al=0X00;
	intdosx(&reg1,&reg2,&segreg);
	h1=reg2.x.ax;
	if(reg2.x.cflag)
		printf("\n Error");
	else
		printf("\n SOURCE FILE IS READING");

	//*********************creating the destination file********************
	printf("\n\nEnter NEW DESTINATION  File2 name to be created:");
	scanf("%s",destfile);
	reg1.h.ah=0X3C; // CREATES THE DESTINATION FILE
	reg1.x.dx=FP_OFF(destfile);
	segreg.ds=FP_SEG(destfile);
	reg1.h.al=0X01;
	intdosx(&reg1,&reg2,&segreg);
	h2=reg2.x.ax;
	if(reg2.x.cflag)
		printf("\n Error");
	else
		printf("\n DESTINATION FILE IS CREATED");


	//*********************opens destination  file in write mode**********
	reg1.h.ah=0X3D;  // Opens file with Handle
	reg1.x.dx=FP_OFF(destfile);
	segreg.ds=FP_SEG(destfile);
	reg1.h.al=0X01;
	intdosx(&reg1,&reg1,&segreg);
	h2=reg2.x.ax;
	if(reg2.x.cflag==0)
	{
		printf("\n\t %s Destination File has opened in write mode",destfile);
	}
	//**************************reading data from file 1*******
	reg1.h.ah=0X3F;  // READ FILE WITH HANDLE
	reg1.x.bx=h1;
	reg1.x.cx=0XFF;
	intdos(&reg1,&reg2);
	h3=reg2.x.ax;
	if(reg2.x.cflag==0)
	{
		printf("\n\t%s SOURCE File reading.",srcfile);
	}
	//**************************writing data to file 2*******
	reg1.h.ah=0X40;  // WRITE SOURCE FILE
	reg1.x.bx=h2;
	reg1.x.cx=h3;
	intdos(&reg1,&reg2);
	if(reg2.x.cflag==0)
	{
		printf("\n\t%s SOURCE File writing",srcfile);
	}
	reg1.h.ah=0X3E;     //CLOSE FILE WITH HANDLE
	reg1.x.bx=h1;
	intdos(&reg1,&reg2);
	reg1.h.ah=0X3E;//CLOSE FILE WITH HANDLE
	reg1.x.bx=h2;
	intdos(&reg1,&reg2);
	printf("FILE COPIED");
break;
case 4: exit();
}
}while(ch>3);
getch();
}
