using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace LTWeb10.Models
{
    public class CartItem
    {
        public int iMaSach { get; set; }
        public string sTenSach { get; set; }
        public string sAnhBia { get; set; }
        public double dDonGia { get; set; }
        public int iSoLuong { get; set; }
        public double ThanhTien
        {
            get { return iSoLuong * dDonGia; }
        }

        tuan10Entities db = new tuan10Entities();

        public CartItem(int maSach)
        {
            SanPham sach = db.SanPhams.Single(n => n.MaSP == maSach);
            if (sach != null)
            {
                iMaSach = maSach;
                sTenSach = sach.TenSP;
                sAnhBia = sach.HinhAnh;
                dDonGia = double.Parse(sach.DonGia.ToString());
                iSoLuong = 1;
            }
        }
    }

    public class GioHang
    {
        public List<CartItem> lst;

        public GioHang()
        {
            lst = new List<CartItem>();
        }

        public GioHang(List<CartItem> lstGH)
        {
            lst = lstGH;
        }

        public int SoMatHang()
        {
            return lst.Count;

        }

        public int TongSLHang()
        {
            return lst.Sum(n => n.iSoLuong);
        }
        public double TongThanhTien()
        {
            return lst.Sum(n => n.ThanhTien);
        }

        public int Them(int iMaSach)
        {
            CartItem sp = lst.Find(n => n.iMaSach == iMaSach);

            if (sp == null)
            {
                CartItem sach = new CartItem(iMaSach);
                if (sach == null)
                {
                    return -1;
                }
                lst.Add(sach);
            }
            else
            {
                sp.iSoLuong++;
            }
            return 1;
        }
    }
}