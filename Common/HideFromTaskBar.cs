using Godot;
using System;
using System.Runtime.InteropServices;

public partial class HideFromTaskBar : Node
{
	// P/Invoke declarations
	[DllImport("user32.dll")]
	private static extern IntPtr GetActiveWindow();

	[DllImport("user32.dll")]
	private static extern long GetWindowLong(IntPtr hwnd, int nIndex);

	[DllImport("user32.dll")]
	private static extern long SetWindowLong(IntPtr hwnd, int nIndex, long dwNewLong);

	// Constants for window style
	private const int GWL_EXSTYLE = -20;
	private const long WS_EX_TOOLWINDOW = 0x00000080L;
	private const long WS_EX_APPWINDOW = 0x00040000L;

	public override void _Ready()
	{
		HideFromTaskbar();
	}

	private void HideFromTaskbar()
	{
		// IntPtr hwnd = GetActiveWindow();
		long style = GetWindowLong(GetActiveWindow(), GWL_EXSTYLE);
		style &= ~WS_EX_APPWINDOW;
		style |= WS_EX_TOOLWINDOW;
		SetWindowLong(GetActiveWindow(), GWL_EXSTYLE, style);
	}
}
