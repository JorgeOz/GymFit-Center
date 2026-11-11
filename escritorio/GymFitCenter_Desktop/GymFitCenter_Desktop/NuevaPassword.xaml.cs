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
    public partial class NuevaPassword : MetroWindow
    {
        public NuevaPassword()
        {
            InitializeComponent();
        }

        private void btnConfirmarNuevaPassword_Click(object sender, RoutedEventArgs e)
        {
            if (string.IsNullOrEmpty(txtNuevaPassword.Password) ||
               string.IsNullOrEmpty(txtConfirmarNuevaPassword.Password))
            {
                MessageBox.Show("Por favor, introduzca su nueva contraseña.",
                    "Error al introducir la contraseña nueva", MessageBoxButton.OK, MessageBoxImage.Error);
            }
            else if (txtNuevaPassword.Password != txtConfirmarNuevaPassword.Password)
            {
                MessageBox.Show("Las contraseñas deben coincidir.",
                    "Error al introducir la contraseña nueva", MessageBoxButton.OK, MessageBoxImage.Error);
            } 
            else
            {
                Login login = new Login();
                login.Show();
                this.Close();
            }
        }
    }
}