using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using LTWeb09_Bai01.Models;

namespace LTWeb09_Bai01.Controllers
{
    public class KhachHangController : Controller
    {
        // GET: KhachHang
        QL_BANSACHEntities dl = new QL_BANSACHEntities();
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
        public ActionResult Login(string tk, string pass)
        {
            KhachHang kh = dl.KhachHangs.SingleOrDefault(k => k.TaiKhoan == tk && k.MatKhau == pass);

            if (kh != null)
            {
                Session["TaiKhoan"] = kh;
                return RedirectToAction("Index", "Home");
            }

            ViewBag.ErrorMessage = "Sai tài khoản hoặc mật khẩu!";
            return View();
        }

        public ActionResult Register()
        {
            return View();
        }

        [HttpPost]
        public ActionResult Register(KhachHang model, string rePass)
        {
            if (model.MatKhau != rePass)
            {
                ViewBag.Error = "Mật khẩu nhập lại không trùng!";
                return View();
            }

            var checkTK = dl.KhachHangs.FirstOrDefault(k => k.TaiKhoan == model.TaiKhoan);
            if (checkTK != null)
            {
                ViewBag.Error = "Tên đăng nhập đã tồn tại!";
                return View();
            }

            dl.KhachHangs.Add(model);
            dl.SaveChanges();

            ViewBag.Success = "Đăng ký thành công! Mời bạn đăng nhập.";
            return RedirectToAction("Login");
        }

    }
}