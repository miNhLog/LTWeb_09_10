using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using LTWeb09_Bai01.Models;
using System.Data.Entity;



namespace LTWeb09_Bai01.Controllers
{
    public class HomeController : Controller
    {
        QL_BANSACHEntities data = new QL_BANSACHEntities();
        public ActionResult Index()
        {
            List<Sach> dsSach = data.Saches.OrderByDescending(s => s.NgayCapNhat).Take(5).ToList();
            return View(dsSach);
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }

        public ActionResult DSMenu_ChuDe()
        {
            List<ChuDe> dsCD = data.ChuDes.Take(10).ToList();
            return PartialView(dsCD);
        }

        public ActionResult DSMenu_NhaXuatBan()
        {
            List<NhaXuatBan> dsNXB = data.NhaXuatBans.Take(10).ToList();
            return PartialView(dsNXB);
        }

        public ActionResult DetailBook(int maSach)
        {
            Sach sach = data.Saches.SingleOrDefault(s => s.MaSach == maSach);
            if(sach == null)
            {
                return HttpNotFound();  
            }
            var cungCD = data.Saches.Where(s => s.MaChuDe == sach.MaChuDe && s.MaSach != sach.MaSach).Take(4).ToList();
            ViewBag.CungChuDe = cungCD;

            var cungNXB = data.Saches.Where(s => s.MaNXB == sach.MaNXB && s.MaSach != sach.MaSach).Take(4).ToList();
            ViewBag.CungNXB = cungNXB;
            return View(sach);
        }

        public ActionResult DSSach_ChuDe(int maCD)
        {
            List<Sach> dsSach = data.Saches.Where(s => s.MaChuDe == maCD).ToList();
            
            if(dsSach == null || dsSach.Count== 0)
            {
                return HttpNotFound("Không tìm thấy sách thuộc chủ đề này");
            } 
            return View(dsSach);
        }

        public ActionResult DSSach_NXB(int maNXB)
        {
            List<Sach> dsSach = data.Saches.Where(s => s.MaNXB == maNXB).ToList();
            return View(dsSach);
        }

    }
}