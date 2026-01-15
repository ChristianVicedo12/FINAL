using Microsoft.AspNetCore.Mvc.RazorPages;
using System.Text.Json;

namespace IskoWalk.Pages;

public class DashboardModel : PageModel
{
    private readonly IHttpClientFactory _httpClientFactory;

    public List<WalkRequestDto> Requests { get; set; } = new();
    public string CurrentUser { get; set; } = "juan.dc"; // TODO: Get from session/auth

    public DashboardModel(IHttpClientFactory httpClientFactory)
    {
        _httpClientFactory = httpClientFactory;
    }

    public async Task OnGetAsync()
    {
        try
        {
            // TODO: Get current user from authentication/session
            // For now, hardcoded as juan.dc
            CurrentUser = "juan.dc";

            var client = _httpClientFactory.CreateClient();
            
            // ✅ Pass current user so we exclude their own requests
            var response = await client.GetAsync($"http://localhost:5012/api/walkrequest/available?userId={CurrentUser}");

            if (response.IsSuccessStatusCode)
            {
                var json = await response.Content.ReadAsStringAsync();
                Requests = JsonSerializer.Deserialize<List<WalkRequestDto>>(json, new JsonSerializerOptions
                {
                    PropertyNameCaseInsensitive = true
                }) ?? new();
                
                Console.WriteLine($"[DEBUG] Loaded {Requests.Count} available requests for {CurrentUser}");
            }
            else
            {
                Console.WriteLine($"[ERROR] API returned status: {response.StatusCode}");
            }
        }
        catch (Exception ex)
        {
            Console.WriteLine($"[ERROR] Dashboard OnGet: {ex.Message}");
        }
    }
}

public class WalkRequestDto
{
    public int Id { get; set; }
    public string RequesterName { get; set; } = "";
    public string FromLocation { get; set; } = "";
    public string ToLocation { get; set; } = "";
    public string WalkTime { get; set; } = "";
    public DateTime WalkDate { get; set; }
    public string? AdditionalNotes { get; set; }
    public string? ContactNumber { get; set; }
}
