using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using LTWeb10.Models;
using System.Data.Entity;

namespace LTWeb10.Controllers
{
    public class HomeController : Controller
    {
        tuan10Entities db = new tuan10Entities();
        public ActionResult Index()
        {
            List<SanPham> dsSp = db.SanPhams.ToList();
            return View(dsSp);
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
    }
}