using UdonSharp;
using UnityEngine;

namespace QvPen.UdonScript
{
    [UdonBehaviourSyncMode(BehaviourSyncMode.NoVariableSync)]
    public class QvPen_InkGroup : UdonSharpBehaviour
    {
        [System.NonSerialized]
        public Transform root;

        public void _Init(string name, Transform parent)
        {
            var go = new GameObject(name);
            root = go.transform;
            SetParentAndResetLocalTransform(root, parent);
        }

        public void _AddChild(Transform child)
        {
            SetParentAndResetLocalTransform(child, root);
        }

        public void _SetParent(Transform parent)
        {
            SetParentAndResetLocalTransform(root, parent);
        }

        private void SetParentAndResetLocalTransform(Transform child, Transform parent)
        {
            if (child == null)
                return;
            child.SetParent(parent);
            child.localPosition = Vector3.zero;
            child.localRotation = Quaternion.identity;
            child.localScale = Vector3.one;
        }
    }
}
