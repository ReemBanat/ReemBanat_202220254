using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;
using Microsoft.Data.Sqlite;
using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;

namespace ReemBanat_202220254.Pages
{
    public class PersonModel
    {
        [Required(ErrorMessage = "Name is required")]
        public string Name { get; set; }

        [Required(ErrorMessage = "Mobile is required")]
        public string Mobile { get; set; }

        [Required(ErrorMessage = "Address is required")]
        public string Address { get; set; }
    }

    public class IndexModel : PageModel
    {
        [BindProperty]
        public PersonModel Person { get; set; }
        public List<PersonModel> PersonsList { get; set; } = new List<PersonModel>();

        string connectionString = "Data Source=MyData.db";

        public void OnGet()
        {
            LoadData();
        }

        private void LoadData()
        {
            using (var connection = new SqliteConnection(connectionString))
            {
                connection.Open();
                var command = connection.CreateCommand();
                command.CommandText = "SELECT Name, Mobile, Address FROM Persons";
                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        PersonsList.Add(new PersonModel
                        {
                            Name = reader.GetString(0),
                            Mobile = reader.GetString(1),
                            Address = reader.GetString(2)
                        });
                    }
                }
            }
        }

        public IActionResult OnPostSave()
        {
            if (!ModelState.IsValid) { LoadData(); return Page(); }

            using (var connection = new SqliteConnection(connectionString))
            {
                connection.Open();
                var command = connection.CreateCommand();
                command.CommandText = "INSERT INTO Persons (Name, Mobile, Address) VALUES ($n, $m, $a)";
                command.Parameters.AddWithValue("$n", Person.Name);
                command.Parameters.AddWithValue("$m", Person.Mobile);
                command.Parameters.AddWithValue("$a", Person.Address);
                command.ExecuteNonQuery();
            }
            return RedirectToPage();
        }

        public IActionResult OnPostDelete()
        {
            using (var connection = new SqliteConnection(connectionString))
            {
                connection.Open();
                var command = connection.CreateCommand();
                command.CommandText = "DELETE FROM Persons WHERE Name = $n";
                command.Parameters.AddWithValue("$n", Person.Name);
                command.ExecuteNonQuery();
            }
            return RedirectToPage();
        }
    }
}