//HDOJ_1398  Square Coins
#include <iostream>
using namespace std;

const int lmax=300;
int c1[lmax+1],c2[lmax+1];

int main(void)
{	
    int n,i,j,k;
	while (cin>>n && n!=0)
	{	
        for (i=0;i<=n;i++)
		{	
            c2[i]=0;         //���ڶ��������Ӱ���ֻ��ǰN�������Խ�����0
            c1[i]=1;        //������һ��������ʵ��Ϊ1+x+x^2+x^3+����x^n
        }
        
		for (i=2;i<=17;i++)   //��������ĺ�����Ӧ1+x^i+x^2i+����
		{	
            for (j=0;j<=n;j++)              //������ʽ��ˣ��Ƚ���һ������ʽ����˺�һ������ʽ��
				for (k=0;k+j<=n;k+=i*i)     //���������˻�����x^n��ɽ�������������һ�������������Ӱ�죬
				{	                        //Ϊʲôʹ��k+=i*i,��ʵ�ʾ���һ�����ɺ�����1+x^(i*i)+x^2(i*i)+������
                    c2[j+k]+=c1[j];	        //û�е���ϵ��Ϊ0,������Ч������ۼ�c1��j�ݣ�
                }                           //���Ǽ�1��ԭ��Ϊ����c1�ۣ��в����ڵ�j�Ҳ����˵x^j��ϵ��Ϊ0
                
			for (j=0;j<=n;j++)   //�����������c1�ۣ��У���c2�ۣ���0���Ա���ѭ��ʹ��
			{	
                c1[j]=c2[j];	
                c2[j]=0;
            }
		}
		cout<<c1[n]<<endl;
	}
	
	return 0;
}