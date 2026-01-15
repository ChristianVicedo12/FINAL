using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace IskoWalk.Pages
{
    public class MyRequestsActiveModel : PageModel
    {
        public void OnGet()
        {
            ViewData["ActivePage"] = "MyRequestsActive";
        }
    }
}
