using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using LTWeb10.Models;

namespace LTWeb10.Controllers
{
    public class KhachHangController : Controller
    {
        tuan10Entities db = new tuan10Entities();
        // GET: KhachHang
        public ActionResult Index()
        {
            return View();
        }

        [HttpGet]
        public ActionResult Login()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Login(string phone, string pass)
        {
            KhachHang kh = db.KhachHangs.SingleOrDefault(k => k.SoDienThoai == phone && k.MatKhau == pass);

            if(kh != null)
            {
                Session["TenKH"] = kh;
                return RedirectToAction("Index", "Home");
            }

            ViewBag.ErrorMessage = "Số điện thoại hoặc mật khẩu không đúng !!";
            return View();
        }

        [HttpGet]
        public ActionResult Register()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Register(KhachHang model, string rePass)
        {
            if(model.MatKhau != rePass)
            {
                ViewBag.ErrorMessage = "Mật khẩu nhập lại không trùng !";
                return View();
            }

            var checkTK = db.KhachHangs.FirstOrDefault(k => k.SoDienThoai == model.SoDienThoai);
            if (checkTK != null)
            {
                ViewBag.ErrorMessage = "Số điện thoại đã tồn tại !";
                return View();
            }

            db.KhachHangs.Add(model);
            db.SaveChanges();

            ViewBag.Success = "Đăng kí thành công! Mời bạn đăng nhập.";
            return RedirectToAction("Login");
        }

        public ActionResult Logout()
        {
            Session.Clear();
            return RedirectToAction("Index", "Home");
        }

    }
}