using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace HovRailKiosk
{
    public static class Helper
    {
        public static ApplicationContext MainContext = new ApplicationContext();
        public static HovRailKioskEntities Db = new HovRailKioskEntities();
    }
}
