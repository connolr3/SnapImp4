using UnityEngine;

public class TeleportZoneRepositioner : MonoBehaviour
{
    // Start is called once before the first execution of Update after the MonoBehaviour is created
    public Transform[] transforms;
    public GameObject[] agents;

    public Transform farAway;
    //  public Enable enable;
    public GameObject teleportZone;

    private int currentIndex = -1;
    private GameObject thisAgent;
    public DataLogger logger;

    void Update()
    {
      
        if (Input.GetKeyDown(KeyCode.N))
        {
         
            newAgent();
        }
        else if (Input.GetKeyDown(KeyCode.S))
        {
            logger.LogAction("start talking");
        }
        else if (Input.GetKeyDown(KeyCode.F))
        {
            logger.LogAction("finish talking");
        }

    }
    public GameObject startObj;
    public bool newAgent() {
        foreach (GameObject agent in agents)
        {
            agent.transform.position = farAway.position;
        }


        if (currentIndex > -1 && currentIndex<transforms.Length)
        {
            agents[currentIndex].SetActive(false);
        }

        currentIndex++;
        if (currentIndex >= transforms.Length || currentIndex >= agents.Length)
        {
            Debug.Log("finished!");
            return false;
        }
      
        startObj.SetActive(false);
        Debug.Log("new agent index is "+currentIndex);
       // teleportZone.SetActive(true);
       


        Vector3 thisSpawn = transforms[currentIndex].position;
        thisAgent = agents[currentIndex];
       

        Debug.Log("currnet talking to:!"+thisAgent.name);
        //thisAgent.SetActive(true);
        Vector3 pos = thisAgent.transform.position;
        pos.x = thisSpawn.x;
        pos.z = thisSpawn.z;
        thisAgent.transform.position = pos;

        Vector3 tpPos = teleportZone.transform.position;
        tpPos.x = thisSpawn.x;
        tpPos.z = thisSpawn.z;
        teleportZone.transform.position = tpPos;

        logger.setAgent(thisAgent.transform);
        return true;



    }
   /* public void randomTransformReposition()
    {
      //  toMatch.GameObject.SetActive(true);
        int index = Random.Range(0, transforms.Length);
        Transform thisTransform = transforms[index]; 
        Vector3 newPos = new Vector3(thisTransform.position.x, toMatch.position.y, thisTransform.position.z);//PRESERVE Y

        Vector3 toMatchEuler = toMatch.rotation.eulerAngles;
        Vector3 thisEuler = thisTransform.rotation.eulerAngles;
        Vector3 newEuler = new Vector3(toMatchEuler.x, thisEuler.y, toMatchEuler.z);
        Quaternion newRot = Quaternion.Euler(newEuler);


        toMatch.position = newPos;
        toMatch.rotation = newRot;


    }*/
}
