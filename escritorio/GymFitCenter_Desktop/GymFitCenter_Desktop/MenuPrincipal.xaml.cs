using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Shapes;
using MahApps.Metro.Controls;
using MahApps.Metro.Controls.Dialogs;

namespace GymFitCenter_Desktop
{
    /// <summary>
    /// Interaction logic for MenuPrincipal.xaml
    /// </summary>
    public partial class MenuPrincipal : MetroWindow
    {
        public MenuPrincipal()
        {
            InitializeComponent();
        }

        private async void menuLateral_OptionsItemClick(object sender, ItemClickEventArgs args)
        {
            var confirmarCierre = await this.ShowMessageAsync("Confirmación", "¿Está seguro de que desea cerrar sesión?", MessageDialogStyle.AffirmativeAndNegative);

            if (confirmarCierre != MessageDialogResult.Affirmative)
            {
                menuLateral.SelectedOptionsIndex = -1;
                return;
            }
            else
            {
                Login login = new Login();
                login.Show();
                this.Close();
            }
        }

        private void menuLateral_ItemClick(object sender, ItemClickEventArgs evento)
        {
            var item = evento.ClickedItem as HamburgerMenuIconItem;
            if (item == null) return;

            switch (item.Tag?.ToString())
            {
                case "clientes":
                    menuLateral.Content = new ClientesView();
                    break;
                case "gimnasios":
                    menuLateral.Content = new GimnasiosView();
                    break;
                default:
                    menuLateral.Content = null;
                    break;
            }
        }
    }
}
