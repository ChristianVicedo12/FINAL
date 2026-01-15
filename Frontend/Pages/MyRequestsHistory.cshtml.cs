using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.RazorPages;

namespace IskoWalk.Pages
{
    public class MyRequestsHistoryModel : PageModel
    {
        public void OnGet()
        {
            ViewData["ActivePage"] = "MyRequestsHistory";
        }
    }
}
