using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using LTWeb10.Models;

namespace LTWeb10.Controllers
{
    public class DatHangController : Controller
    {
        // GET: DatHang
        tuan10Entities db = new tuan10Entities();
        public ActionResult Index()
        {
            return View();
        }

        public ActionResult ThemGioHang(int maSP)
        {
            GioHang gh = (GioHang)Session["gh"];
            if (gh == null)
                gh = new GioHang();


            int kq = gh.Them(maSP);
            Session["gh"] = gh;

            if (Session["TenKH"] == null)
            {
                TempData["Message"] = "Bạn phải đăng nhập để mua hàng!";
                return RedirectToAction("Login", "KhachHang");
            }

            return RedirectToAction("Index", "Home");
        }

        public ActionResult XemGioHang()
        {
            GioHang gh = (GioHang)Session["gh"];
            return View(gh);
        }

        public ActionResult DatHang()
        {
            GioHang gh = Session["gh"] as GioHang;
            var kh = Session["TenKH"] as KhachHang;

            if (kh == null)
                return RedirectToAction("Login", "KhachHang");

            ViewBag.HoTen = kh.TenKH;
            ViewBag.DienThoai = kh.SoDienThoai;
            return View();
        }

        [HttpPost]
        public ActionResult DatHang(string HoTen, string DienThoai, string DiaChi)
        {
            GioHang gh = Session["gh"] as GioHang;
            var kh = Session["TenKH"] as KhachHang;

            if (gh == null || gh.lst.Count == 0)
            {
                TempData["Msg"] = "Giỏ hàng trống!";
                return RedirectToAction("XemGioHang");
            }

            using (tuan10Entities db = new tuan10Entities())
            {
                HoaDon hd = new HoaDon
                {
                    MaKH = kh.MaKH,
                    NgayHoaDon = DateTime.Now
                };

                db.HoaDons.Add(hd);
                db.SaveChanges();

                foreach (var sp in gh.lst)
                {
                    ChiTiet ct = new ChiTiet
                    {
                        MaHD = hd.MaHD,
                        MaSP = sp.iMaSach,
                        SoLuong = sp.iSoLuong
                    };
                    db.ChiTiets.Add(ct);
                }
                db.SaveChanges();
            }

            Session["gh"] = null;
            return RedirectToAction("Index", "Home");
        }

    }
}