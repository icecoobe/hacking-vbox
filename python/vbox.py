
import win32com
from win32com.client import Dispatch, constants

vbox = win32com.client.Dispatch("VirtualBox.VirtualBox")
session = win32com.client.Dispatch("VirtualBox.Session")
mach = vbox.findMachine("dos2")
progress = mach.launchVMProcess(session, "gui", "")
progress.waitForCompletion(-1)

