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
using System.Text.RegularExpressions;

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
            string dni = txtDNI.Text.Trim().ToUpper();

            if (string.IsNullOrEmpty(dni) || string.IsNullOrEmpty(txtPassword.Password))
            {
                MessageBox.Show("Por favor, introduzca su DNI y su contraseña.",
                    "Error de inicio de sesión", MessageBoxButton.OK, MessageBoxImage.Error);
                return;
            }

            if (!DniValido(dni))
            {
                MessageBox.Show("El DNI no es válido.",
                    "Error de inicio de sesión", MessageBoxButton.OK, MessageBoxImage.Error);
                txtDNI.Focus();
                return;
            }

            // Aquí irá la comprobación contra la BD
            MenuPrincipal menuPrincipal = new MenuPrincipal();
            menuPrincipal.Show();
            this.Close();
        }

        private bool DniValido(string dni)
        {
            if (!Regex.IsMatch(dni, @"^\d{8}[A-Z]$"))
            {
                return false;
            }
            else
            {
                const string letras = "TRWAGMYFPDXBNJZSQVHLCKE";
                int numero = int.Parse(dni.Substring(0, 8));
                return dni[8] == letras[numero % 23];
            }
        }

        private void lnkCorreo_Click(object sender, RoutedEventArgs e)
        {
            CorreoRecuperacion correoRecuperacion = new CorreoRecuperacion();
            correoRecuperacion.Show();
            this.Close();
        }
    }
}