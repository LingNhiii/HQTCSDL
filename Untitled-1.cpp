#include <bits/stdc++.h>
using namespace std;

struct Hang
{
    char MaHang[10];
    char TenHang[30];
    char DonVi[10];
    float Gia;
    int SoLuong;
};
struct LIST
{
    Hang ds[100];
    int count;
};
void create_list(LIST &l)
{
    l.count = -1;
}
void Nhap_Hang(Hang &x)
{
    cout << "Ma Hang: ";
    fflush(stdin);
    gets(x.MaHang);
    cout << "Ten Hang: ";
    fflush(stdin);
    gets(x.TenHang);
    cout << "Don viL: ";
    fflush(stdin);
    gets(x.DonVi);
    cout << "Don Gia: ";
    cin >> x.Gia;
    cout << "So Luong: ";
    cin >> x.SoLuong;
}
void Xuat_Hang(Hang x)
{
    cout << setw(10) << x.MaHang;
    cout << setw(30) << x.TenHang;
    cout << setw(10) << x.DonVi;
    cout << setw(10) << x.Gia;
    cout << setw(10) << x.SoLuong << endl;
}
void Xuat_DS(LIST l)
{
    cout << setw(10) << "MaHang";
    cout << setw(30) << "TenHang";
    cout << setw(10) << "DonVi";
    cout << setw(10) << "Gia";
    cout << setw(10) << "SoLuong" << endl;
    for (int i = 0; i <= l.count; i++)
    {
        Xuat_Hang(l.ds[i]);
    }
}
void Nhap_DS(LIST &l, int n)
{
    for (int i = 0; i < n; i++)
    {
        Hang x;
        Nhap_Hang(x);
        l.count++;
        l.ds[l.count] = x;
    }
}
void insert_DS(LIST &l, Hang x)
{
    l.count++;
    for (int i = l.count; i >= 3; i--)
    {
        l.ds[i] = l.ds[i - 1];
    }
    l.ds[3] = x;
}

void Selection_soft(LIST &l)
{
    for (int i = 0; i < l.count - 1; i++)
    {
        int m = i;
        for (int j = i + 1; j < l.count; j++)
        {
            if (l.ds[j].Gia > l.ds[m].Gia)
            {
                m = j;
            }
        }
        if (m != i)
        {
            swap(l.ds[i], l.ds[m]);
        }
    }
}
int main()
{
    LIST L;
    create_list(L);
    int n;
    cin >> n;
    Hang x;
    Nhap_Hang(x);
    Nhap_DS(L, n);
    Xuat_DS(L);
    insert_DS(L, x);
    Xuat_DS(L);
    Selection_soft(L);
    Xuat_DS(L);
    return 0;
}