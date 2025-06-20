using System;
using QvPen.UdonScript;

class Program {
    static int Main() {
        var pen = new QvPen_Pen();
        // Setup stub pools
        pen.inkPoolSynced = new UnityEngine.Transform[] { };
        pen.inkPoolNotSynced = new UnityEngine.Transform[] { };
        pen.SaveState();
        pen.CopyStateToClipboard();
        pen.RestoreState();
        pen.PasteStateFromClipboard();
        var group = pen.CreateInkGroup("group");
        var ink = new UnityEngine.GameObject().transform;
        pen.SetInkParent(ink, group);
        Console.WriteLine("Tests ran");
        return 0;
    }
}
