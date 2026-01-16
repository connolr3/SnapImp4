using UnityEngine;
using UnityEngine.InputSystem;

public class IPDChecker : MonoBehaviour
{
    public GameObject agent;
    public GameObject player;
    public float moveSpeed = 2f;
    public CircleFillHandler fillHandler;
    public GameObject circleIndicator;

    private bool buttonPressed = false;
    private float buttonHoldDuration = 0f;
    private float requiredHoldDuration = 1.5f;
    public static float DistanceXZ(Vector3 a, Vector3 b)
    {
        a.y = 0f;
        b.y = 0f;
        return Vector3.Distance(a, b);
    }

    void Update()
    {
      //  Debug.Log("Update running");
      //  Debug.Log($"TimeScale: {Time.timeScale}");
      
          //  Debug.Log($"Update frame: {Time.frameCount}");
     

        // Log trigger values every frame
        float leftTrigger = OVRInput.Get(OVRInput.RawAxis1D.LIndexTrigger);
        float rightTrigger = OVRInput.Get(OVRInput.RawAxis1D.RIndexTrigger);
       // if (!buttonPressed && (leftTrigger > 0.5f || rightTrigger > 0.5f))
       // {
       //     Debug.Log("Trigger pressed");
       // }
        //Debug.Log($"Triggers - L: {leftTrigger:F2}, R: {rightTrigger:F2}");

    
        // Read RIGHT thumbstick
        //float stickY = Gamepad.current.rightStick.ReadValue().y;
        Vector2 stick = OVRInput.Get(OVRInput.Axis2D.PrimaryThumbstick);


        float stickY = stick.x;

        //  Debug.Log($"Update frame: {Time.frameCount}"+stickY);

        //   stickY = OVRInput.Get(OVRInput.Axis2D.SecondaryThumbstick[1]);

        //   Debug.Log($"Update frame: {Time.frameCount}"+stickY);
        Vector2 rightStick = OVRInput.Get(OVRInput.Axis2D.PrimaryThumbstick);
       // Debug.Log($"Right Stick: X={rightStick.x:F2}, Y={rightStick.y:F2}");
        Vector2 stickRight = OVRInput.Get(OVRInput.Axis2D.PrimaryThumbstick, OVRInput.Controller.RTouch);
         stickY = stickRight.y;
       // Debug.Log($"Right Stick: X={rightStick.x:F2}, Y={rightStick.y:F2}");

        // Move agent
        if (Mathf.Abs(stickY) > 0.01f)
        {
          //  Debug.Log("Moving agent");
            agent.transform.position +=
                player.transform.forward * stickY * moveSpeed * Time.deltaTime;
        }

        // Trigger hold logic
     //   if (leftTrigger > 0.5f || rightTrigger > 0.5f)
            if (OVRInput.Get(OVRInput.RawAxis1D.LIndexTrigger) > 0.5f || OVRInput.Get(OVRInput.RawAxis1D.RIndexTrigger) > 0.5f)
            {
                buttonPressed = true;
                circleIndicator.SetActive(true);
                buttonHoldDuration += Time.deltaTime;
                // float originalValue = 2.0f; // Replace with your actual value
                float mappedValue = MapValue(buttonHoldDuration, 0f, requiredHoldDuration, 0f, 100f);
                CircleFillHandler.fillValue = mappedValue;
            }
            else
            {
                CircleFillHandler.fillValue = 0;
                circleIndicator.SetActive(false);
                if (buttonPressed)
                {

                    buttonPressed = false;

                    if (buttonHoldDuration >= requiredHoldDuration)
                    {
                    // Button held for at least 3 seconds
                    Debug.Log("click");
                    Debug.Log("xz"+DistanceXZ(player.transform.position,agent.transform.position));
                    agent.SetActive(false);
                    }
                    // Reset button hold duration
                    buttonHoldDuration = 0f;
                }
            }
    }

    float MapValue(float value, float inMin, float inMax, float outMin, float outMax)
    {
        float mappedValue =
            (value - inMin) * (outMax - outMin) / (inMax - inMin) + outMin;

        return Mathf.Clamp(mappedValue, outMin, outMax);
    }
}
