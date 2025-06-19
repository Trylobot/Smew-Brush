namespace UnityEngine {
    public class Object {}
    public class Component : Object {}
    public class Behaviour : Component {}
    public class MonoBehaviour : Behaviour {}

    public struct Vector3 {
        public float x,y,z;
        public Vector3(float x,float y,float z){this.x=x;this.y=y;this.z=z;}
        public static Vector3 zero => new Vector3(0,0,0);
        public static Vector3 one => new Vector3(1,1,1);
        public static Vector3 right => new Vector3(1,0,0);
    }

    public struct Quaternion {}

    public class GameObject : Object {
        public string name;
        public Transform transform = new Transform();
        public static GameObject Find(string name) => null;
        public T GetComponent<T>() where T: Component => null;
        public bool activeSelf;
    }

    public class Transform : Component {
        public Vector3 localPosition;
        public Quaternion localRotation;
        public Vector3 localScale;
        public GameObject gameObject = new GameObject();
        public void SetParent(Transform parent){}
        public void SetAsFirstSibling(){}
        public Transform Find(string name)=>null;
        public T GetComponent<T>() where T: Component => null;
    }

    public class TrailRenderer : Component {
        public int positionCount;
        public Material material { get; set; }
        public void GetPositions(Vector3[] arr){}
    }

    public class LineRenderer : Component {
        public int positionCount;
        public GameObject gameObject => new GameObject();
        public void GetPositions(Vector3[] arr){}
    }

    public class Material : Object {}
    public class AudioSource : Behaviour {}
    public class Renderer : Component { public Material sharedMaterial; }
    public class Collider : Component { public GameObject gameObject => new GameObject(); }
    public class MeshCollider : Collider {}
    public class SphereCollider : Collider { public bool enabled; public float radius; }

    public class Gradient { }

    public static class Mathf {
        public static float Abs(float v)=>v<0?-v:v;
        public static int Max(int a,int b)=>a>b?a:b;
        public static float Min(float a,float b)=>a<b?(a<b?a:b):(b<a?b:a);
    }

    public struct Color { public float r,g,b,a; public Color(float r,float g,float b,float a){this.r=r;this.g=g;this.b=b;this.a=a;} }
    public static class ColorUtility { public static string ToHtmlStringRGB(Color c)=>""; }

    public static class Debug {
        public static void Log(object message,Object context=null){}
        public static void LogWarning(object message,Object context=null){}
        public static void LogError(object message,Object context=null){}
    }

    public static class PlayerPrefs {
        private static System.Collections.Generic.Dictionary<string,string> store = new System.Collections.Generic.Dictionary<string,string>();
        public static void SetString(string key,string value){store[key]=value;}
        public static string GetString(string key,string def=""){return store.ContainsKey(key)?store[key]:def;}
        public static void Save(){}
    }

    public static class GUIUtility {
        public static string systemCopyBuffer { get; set; }
    }
}

namespace UdonSharp {
    public class UdonSharpBehaviour : UnityEngine.MonoBehaviour {}
    public class UdonBehaviourSyncModeAttribute : System.Attribute { public UdonBehaviourSyncModeAttribute(object mode){} }
}

namespace VRC.SDK3.Components { public class VRCObjectSync : UnityEngine.MonoBehaviour {} public class VRC_Pickup : UnityEngine.MonoBehaviour {} }
namespace VRC.SDKBase {
    public static class Networking { public static VRCPlayerApi LocalPlayer => null; public static string GetUniqueName(UnityEngine.GameObject go)=>""; public static bool IsOwner(UnityEngine.GameObject go)=>true; public static void SetOwner(VRCPlayerApi player,UnityEngine.GameObject go){} }
    public class VRCPlayerApi { public static int GetPlayerCount()=>1; public int playerId=>0; }
    public enum NetworkEventTarget { All }
}
namespace VRC.Udon.Common.Interfaces { }
namespace VRC.Udon.Common { public class UdonSyncedAttribute : System.Attribute { } }
namespace TMPro { public class TMP_Text {} public class TMP_InputField { public string text; } }
namespace UnityEngine.UI { public class Slider{} public class Toggle{} }
