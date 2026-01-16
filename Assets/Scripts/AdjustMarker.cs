using Oculus.Interaction;
//using System.Numerics;
using System.Security.Cryptography.X509Certificates;
using Unity.VisualScripting.Antlr3.Runtime.Tree;
using UnityEngine;
using UnityEngine.Timeline;
using UnityEngine.UI;

public class AdjustMarker : MonoBehaviour
{
    private Transform DestinationRecticle;
    public GameObject SnapPoint;
    private bool hovering = false;
    [Tooltip("adjustment madnitude")]
    private float adjustment = 100f;
    public IPDSetter ipdsetter;
    public Transform Player;
    [Tooltip("angle the correction is to be made in (in degrees) 0 is forward, 90 right, 180 backwards and -90 left.")]
    public float degreeOfAdjustment;

    [Tooltip("used to check if the teleport is made using left or right controller")]
    public GameObject leftHand;
    [Tooltip("used to check if the teleport is made using left or right controller")]
    public GameObject rightHand;

    public Transform leftRecticle;
    public Transform rightRecticle;

    public Transform cylinder;


    public bool IPDCorrection;
   // public float IPD = 1.8f;
    public Transform interactant;
  /*  public void changeDegree(Scrollbar scroll)
    {
        degreeOfAdjustment = scroll.value;
    }
    public void changeDegree(float degree)
    {
        degreeOfAdjustment = degree;
    }*/


    public void startHover()
    {
        //Debug.Log("left hand teleporting"+ leftHand.activeSelf);
        // Debug.Log("left hand teleporting (inHierarchy): " + leftHand.activeInHierarchy);

        // Debug.Log("right hand teleporting" + rightHand.activeSelf);
        // Debug.Log("right hand teleporting (inHierarchy): " + rightHand.activeInHierarchy);
        adjustment = ipdsetter.getIPD();
        Debug.Log(adjustment);
        if (leftHand.activeInHierarchy)
        {
            DestinationRecticle = leftRecticle;
            Debug.Log("left hand teleporting");
        }
        else if (rightHand.activeInHierarchy) 
        {
            DestinationRecticle =rightRecticle;
            Debug.Log("right hand teleporting");
        }
            hovering = true;
    }
    private float yPosition;

   // public MyStaircasemanager msm;
                               
    private void Start()
    {
       
        adjustment = ipdsetter.getIPD();
        Vector3 scale = cylinder.transform.localScale;
        scale.x = adjustment * 6f;
        scale.z = adjustment * 6f;
        cylinder.transform.localScale = scale;

        yPosition = SnapPoint.transform.position.y;
        Cursor.lockState = CursorLockMode.None;
        Cursor.visible = true;
       // SnapPoint.GetComponent<MeshRenderer>().enabled = msm.enabletesting();
    }

    /* public void setDegree(float angle)
     {
         degreeOfAdjustment = angle;
     }
   /*  public void setMagnitude(float amount)
     {
        adjustment = amount;
     }*/
    public void endHover()
    {
        hovering = false;
    }
    // Update is called once per frame
    void Update()
    {
        if (hovering &&!IPDCorrection)
        {
            Debug.Log("adjustment"+adjustment);
            // Direction from player to destination in XZ plane
            Vector3 flatDirection = DestinationRecticle.position - Player.position;
            flatDirection.y = 0;
            flatDirection.Normalize();

            // Convert degrees to radians
            float angleRad = degreeOfAdjustment * Mathf.Deg2Rad;

            // Rotate vector around Y-axis (clockwise)
            float cos = Mathf.Cos(angleRad);
            float sin = Mathf.Sin(angleRad);

            Vector3 rotatedDirection = new Vector3(
                flatDirection.x * cos + flatDirection.z * sin,
                0,
                -flatDirection.x * sin + flatDirection.z * cos
            );//using rotation matrix

            // Compute new position offset from destination
            Vector3 newPosition = DestinationRecticle.position + rotatedDirection * adjustment;
            Debug.Log("adjustment" + adjustment);
            newPosition.y = yPosition; // Keep original Y height

            // Set SnapPoint
            SnapPoint.transform.position = newPosition;
            //   SnapPoint.transform.position = new Vector3(DestinationRecticle.position.x-adjustment, yPosition, DestinationRecticle.position.z);
        }
        if (hovering && IPDCorrection)
        {
            Debug.Log("hovering");
            // Direction from interactant toward the destination reticle (XZ plane only)
            Vector3 flatDirection = DestinationRecticle.position - interactant.position;
            flatDirection.y = 0;

            if (flatDirection.sqrMagnitude < 0.0001f)
                return; // safety checkf

            flatDirection.Normalize();

            // Optional: apply angular offset if you still want degreeOfAdjustment
            float angleRad = degreeOfAdjustment * Mathf.Deg2Rad;
            Quaternion rotation = Quaternion.AngleAxis(degreeOfAdjustment, Vector3.up);
            Vector3 rotatedDirection = rotation * flatDirection;

            // Place marker adjustment meters away from interactant
            Vector3 newPosition = interactant.position + rotatedDirection * adjustment;
            newPosition.y = yPosition;

            SnapPoint.transform.position = newPosition;
        }

    }
}
