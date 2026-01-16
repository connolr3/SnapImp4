using UnityEngine;

public class BlockChanges : MonoBehaviour
{
    public int block = 0;
    public string[] blockTypes = new string[] { "s", "m", "l" };
    public float[] teleportDistances = new float[] { 2f, 8.5f, 10f };
   // public MyStaircasemanager manager;
    public GameObject[] spawns;

    private float multiplier;
    void Start()
    {
        float thisDistance = teleportDistances[block];
        float thisXZCoord = Mathf.Sqrt(thisDistance);
         thisXZCoord = Mathf.Sqrt((thisDistance*thisDistance)/2);
        float roomDim = (thisDistance * 2) + 2;
        Debug.Log(thisXZCoord);
        Debug.Log("__________________________________");
      //  Debug.Log(spawns[0].transform.position);
      //note that this chsnges world position - the position of the actual object may differ if it has a parent object - which it currently does!
        spawns[0].transform.position = new Vector3(thisXZCoord, 0.03f, thisXZCoord);
      //  Debug.Log(spawns[0].transform.position);
        spawns[1].transform.position = new Vector3(-1f*thisXZCoord, 0.03f, -1f * thisXZCoord);
        spawns[2].transform.position = new Vector3(-1f * thisXZCoord, 0.03f, thisXZCoord);
        spawns[3].transform.position = new Vector3(thisXZCoord, 0.03f, -1f * thisXZCoord);
 // foreach(GameObject spawn in spawns)
   //     {
       //     spawn.transform.GetChild(0).gameObject.SetActive(manager.enableTesting);
     //   }


    }


}
