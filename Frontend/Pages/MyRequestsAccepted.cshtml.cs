using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace IskoWalk.Pages
{
    public class MyRequestsAcceptedModel : PageModel
    {
        public void OnGet()
        {
            ViewData["ActivePage"] = "MyRequestsAccepted";
        }
    }
}
