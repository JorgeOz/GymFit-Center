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
    /// Interaction logic for GimnasioDetalle.xaml
    /// </summary>
    public partial class GimnasioDetalle : MetroWindow
    {
        public GimnasioDetalle()
        {
            InitializeComponent();
        }

        private async void btnEliminar_Click(object sender, RoutedEventArgs e)
        {
            var ajustes = new MetroDialogSettings();
            ajustes.AffirmativeButtonText = "Eliminar";
            ajustes.NegativeButtonText = "Cancelar";

            var resultado = await this.ShowMessageAsync(
                "Eliminar gimnasio",
                "¿Seguro que quieres eliminar este gimnasio? Esta acción no se puede deshacer.",
                MessageDialogStyle.AffirmativeAndNegative,
                ajustes);

            if (resultado != MessageDialogResult.Affirmative)
            {
                return;
            }

            // TODO: eliminar el gimnasio en la BD
            DialogResult = true;
        }
    }
}
