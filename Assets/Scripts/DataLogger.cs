using System.IO;
using System.Text;
using UnityEngine;
using static UnityEngine.GraphicsBuffer;

public class DataLogger : MonoBehaviour
{
    [Header("Recording")]
    public bool recordData = false;

    [Header("File Settings")]
    public string fileName = "teleport_log2.csv";

    private string filePath;
    private StreamWriter writer;
    public Transform leftRecticle;
    public Transform rightRecticle;
    private Vector3 active;
    public Transform agent;

    public GameObject teleportZone;

    public void setAgent(Transform currentAgent) { 
    agent = currentAgent;
    }
    void Start()
    {
        filePath = Path.Combine(Application.persistentDataPath, fileName);

        // Create file & header if it doesn't exist
        if (!File.Exists(filePath))
        {
            writer = new StreamWriter(filePath, false, Encoding.UTF8);
            writer.WriteLine("timestamp,teleport_type,teleport_time,snapmarker_x,snapmarker_y,snapmarker_z,aim_x,aim_y,aim_z,snapcorrection,distancetoagent");
            writer.Flush();
        }
        else
        {
            writer = new StreamWriter(filePath, true, Encoding.UTF8);
        }
        Debug.Log("saving file at: "+filePath);
    }

    void OnDestroy()
    {
        if (writer != null)
        {
            writer.Flush();
            writer.Close();
        }
    }
 
    public Transform Marker;
    public void LogRegularTeleport() {
        Debug.Log("teleport occuring");
        if (!recordData || Marker == null)
            return;

        if (leftRecticle != null && leftRecticle.gameObject.activeInHierarchy)
        {
            active = leftRecticle.position;
        }
        else if (rightRecticle != null && rightRecticle.gameObject.activeInHierarchy)
        {
            active = rightRecticle.position;
        }
        else
        {
            // No active reticle
            return;
        }

        LogTeleport("teleport", 0f, Marker.position);
    }
    public void LogSnap()
    {
        Debug.Log("snap occuring");
        
        if (!recordData || Marker == null)
            return;

        if (leftRecticle != null && leftRecticle.gameObject.activeInHierarchy)
        {
            active = leftRecticle.position;
        }
        else if (rightRecticle != null && rightRecticle.gameObject.activeInHierarchy)
        {
            active = rightRecticle.position;
        }
        else
        {
            // No active reticle
            return;
        }

        LogTeleport("snap", 0f, Marker.position);
        Invoke(nameof(Disable), 0.1f);
    }

    public Transform farAway;
    public bool disableAfterFirst=false;
    public void Disable()
    {
        if (disableAfterFirst) {
            teleportZone.transform.position = farAway.position;
        }
        
    }

    public static float DistanceXZ(Vector3 a, Vector3 b)
    {
        a.y = 0f;
        b.y = 0f;
        return Vector3.Distance(a, b);
    }
    public Transform player;
    public void LogTeleport(
        string teleportType,
        float teleportTime,
 
        Vector3 teleportPosition
        )
    {
        Debug.Log("logging occuring");
        if (!recordData || writer == null)
            return;

        float snapMag = DistanceXZ(active, Marker.position);
        float direction = (DistanceXZ(Marker.position, agent.position) > DistanceXZ(active, agent.position)) ? -1 : +1;
        float distancetoagent = DistanceXZ(agent.position, player.position);

        snapMag = snapMag * direction;
        string line = string.Format(
              "{0},{1},{2},{3},{4},{5},{6},{7},{8},{9},{10}",
            System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff"),
            teleportType,
            teleportTime,
            teleportPosition.x,
            teleportPosition.y,
            teleportPosition.z,
            active.x,
            active.y,
            active.z,
            snapMag.ToString(),
            distancetoagent
            
                 
        );


        writer.WriteLine(line);
        writer.Flush();
    }


    public void LogAction(string action)
    {
        Debug.Log("logging start talking");
        if (!recordData || writer == null)
            return;

        float distancetoagent = DistanceXZ(agent.position, active);
        string line = string.Format(
              "{0},{1},{2},{3},{4},{5},{6},{7},{8},{9},{10}",
            System.DateTime.Now.ToString("yyyy-MM-dd HH:mm:ss.fff"),
            action + agent.name,
            "",
            "",
            "",
            "",
             "",
            "",
            "",
           "",
            distancetoagent


        );
        writer.WriteLine(line);
        writer.Flush();
    }

}
