using UnityEngine;

public class ChangeMaterial : MonoBehaviour
{
    // Start is called once before the first execution of Update after the MonoBehaviour is created
    public Material originalMaterial;
    public Material alternativeMaterial;
    public Renderer thisRenderer;
 

    void Start()
    {
        revokeMaterial();
      //  thisRenderer=GetComponent<Renderer>();
    }

   public void changeMaterial()
    {
        thisRenderer.material = alternativeMaterial;
    }

    public void revokeMaterial()
    {
        thisRenderer.material = alternativeMaterial;
    }
}
