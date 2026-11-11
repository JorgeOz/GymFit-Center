using System.Text;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using MahApps.Metro.Controls;

namespace GymFitCenter_Desktop
{
    // Lógica de interacción para la ventana principal con soporte de MahApps.Metro
    public partial class Login : MetroWindow
    {
        public Login()
        {
            InitializeComponent();
        }

        private void btn_Click(object sender, RoutedEventArgs e)
        {
            MenuPrincipal menuPrincipal = new MenuPrincipal();
            menuPrincipal.Show();
            this.Close();
        }

        private void lnkCorreo_Click(object sender, RoutedEventArgs e)
        {
            CorreoRecuperacion correoRecuperacion = new CorreoRecuperacion();
            correoRecuperacion.Show();
            this.Close();
        }
    }
}