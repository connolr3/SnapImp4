using UnityEngine;

public class TeleportHandTracker : MonoBehaviour
{
    // Start is called once before the first execution of Update after the MonoBehaviour is created
    public GameObject leftActivate;
    public GameObject rightActivate;
    private string mostRecentActive="null";
   public void setMostRecent()
    {
        if (leftActivate.activeSelf)
        {
            mostRecentActive = "left";
        }
        else
        {
            mostRecentActive = "right";
        }
    }
    public string getHand()
    {
        return mostRecentActive;
    }
 
}
