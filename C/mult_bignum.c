#include<stdio.h>
#include<string.h>

char str1[1000],str2[1000],str3[1000];

void mult(char a[],char b[],char s[])

{
    int i,j,k=0,alen,blen,sum=0,res[65][65]={0},flag=0;

    char result[65];

    alen=strlen(a);blen=strlen(b); 

    for (i=0;i<alen;i++)

        for (j=0;j<blen;j++)
        
            res[i][j]=(a[i]-'0')*(b[j]-'0');

    for (i=alen-1;i>=0;i--)

        {
            for (j=blen-1;j>=0;j--)
                
                sum=sum+res[i+blen-j-1][j];

            result[k]=sum%10;

            k=k+1;

            sum=sum/10;

        }

    for (i=blen-2;i>=0;i--)

        {
            for (j=0;j<=i;j++)
            
                sum=sum+res[i-j][j];

            result[k]=sum%10;

            k=k+1;

            sum=sum/10;

        }

    if (sum!=0)
    
        {
            result[k]=sum;
            k=k+1;
        }

    for (i=0;i<k;i++)
    
        result[i]+='0';

    for (i=k-1;i>=0;i--)
    
        s[i]=result[k-1-i];

    s[k]='\0';

    while(1)

    {
        if (strlen(s)!=strlen(a)&&s[0]=='0') 

            strcpy(s,s+1);

        else

            break;

        }

}

int main()
{
    gets(str1);
    gets(str2);
    mult(str1,str2,str3);
    puts(str3);
    system("pause");
    return 0;    
}
