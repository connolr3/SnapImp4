using UnityEngine;
using System.Collections;
public class Enable : MonoBehaviour
{
   
    public GameObject[] Objects;
    public void DisableObjs()
    {
        // Disable all objects in the array
        if (Objects != null)
        {
            foreach (GameObject obj in Objects)
            {
                if (obj != null)
                {
                    obj.SetActive(false);
                }
            }
        }
    }
   
    public void EnableObjs()
    {
        // Disable all objects in the array
        if (Objects != null)
        {
            foreach (GameObject obj in Objects)
            {
                if (obj != null)
                {
                    obj.SetActive(true);
                }
            }
        }
    }
    private float delay = 0.4f;
    public void EnableObjsAfterDelay()
    {
        Debug.Log("enabling");
        StartCoroutine(EnableAfterDelayCoroutine());
    }
    private IEnumerator EnableAfterDelayCoroutine()
    {
        yield return new WaitForSeconds(delay);

        if (Objects != null)
        {
            foreach (GameObject obj in Objects)
            {
                if (obj != null)
                {
                    obj.SetActive(true);
                }
            }
        }
    }
}
