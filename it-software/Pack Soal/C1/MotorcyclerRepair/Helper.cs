using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;

namespace MotorcyclerRepair
{
    public static class Helper
    {
        public static MotorcycleRepairEntities Db = new MotorcycleRepairEntities();
        public static ApplicationContext MainContext = new ApplicationContext();
        public static string UserCode { get; set; }
    }
}
