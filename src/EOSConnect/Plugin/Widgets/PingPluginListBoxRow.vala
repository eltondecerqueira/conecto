/**
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License version 2 as
 * published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License along
 * with this program; if not, write to the Free Software Foundation, Inc.,
 * 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 *
 * AUTHORS
 * gyan000 <gyan000 (at] ijaz.fr>
 */
using EOSConnect.Widgets;
using MConnect;

namespace EOSConnect.Plugin.Widgets {
    
    public class PingPluginListBoxRow : PluginListBoxRow {

        public PingPluginListBoxRow (
                PluginInterface plugin_interface,
                Device device
        ) {
            Object (
                plugin_interface: plugin_interface,
                device: device
            );
        }

        public override void update_ui () {

            var row_ping_button = new Gtk.Button.with_label ("ping");
            row_ping_button.valign = Gtk.Align.CENTER;
            row_ping_button.sensitive = device.settings.get_boolean (plugin_interface.settings_key_is_active);

            row_grid.attach (row_image, 0, 0, 1, 2);
            row_grid.attach (row_name, 1, 0, 1, 1);
            row_grid.attach (row_description, 1, 1, 1, 1);
            row_grid.attach (row_ping_button, 2, 0, 1, 2);
            row_grid.attach (row_switch, 3, 0, 1, 2);


            add (row_grid);

            row_ping_button.clicked.connect(() => {
                if (device.has_capability_handler (PingHandler.PING)) {
                    ((PingHandler)device.get_path_capability_handler(PingHandler.PING)).send_ping (device);
                }
            });

            row_switch.notify["active"].connect (() => {
                row_ping_button.sensitive = row_switch.active;
                row_configure_button.sensitive = row_switch.active;
                row_description.sensitive = row_switch.active;
                row_name.sensitive = row_switch.active;
                row_image.sensitive = row_switch.active;
            });
        }
    }
}
