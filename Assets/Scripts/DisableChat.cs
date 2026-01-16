using UnityEngine;
using UnityEngine.Events;

public class DisableChat : MonoBehaviour
{
    public UnityEvent onStart;

    void Start()
    {
        onStart?.Invoke();
    }
}
