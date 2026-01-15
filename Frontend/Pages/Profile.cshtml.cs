using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace IskoWalk.Pages
{
    public class ProfileModel : PageModel
    {
        public void OnGet()
        {
            ViewData["ActivePage"] = "Profile";
        }
    }
}
