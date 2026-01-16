using UnityEngine;
using System.Collections.Generic;

public class ObjectSpawner : MonoBehaviour
{
    public GameObject[] objectPrefabs; // Array of unique object prefabs
    public Transform cylinderCenter;
    public float radius = 10f; // Distance from cylinder center
    public float minArcDistance = 7f; // Min arc distance between objects

    void Start()
    {
        SpawnObjects();
    }

    void SpawnObjects()
    {
        int objectCount = Mathf.Min(objectPrefabs.Length, 4); // Limit to 4 unique objects max

        List<GameObject> shuffledPrefabs = new List<GameObject>(objectPrefabs);
        Shuffle(shuffledPrefabs);

        List<float> usedAngles = new List<float>();
        float minAngleDiff = minArcDistance / radius; // in radians
        int attempts = 0;
        int maxAttempts = 1000;

        int spawned = 0;
        while (spawned < objectCount && attempts < maxAttempts)
        {
            float angle = Random.Range(0f, Mathf.PI * 2f);
            bool tooClose = false;

            foreach (float used in usedAngles)
            {
                float diff = Mathf.Abs(Mathf.DeltaAngle(Mathf.Rad2Deg * angle, Mathf.Rad2Deg * used) * Mathf.Deg2Rad);
                if (diff < minAngleDiff)
                {
                    tooClose = true;
                    break;
                }
            }

            if (!tooClose)
            {
                usedAngles.Add(angle);

                Vector3 spawnPos = new Vector3(
                    Mathf.Cos(angle) * radius,
                    0f,
                    Mathf.Sin(angle) * radius
                ) + cylinderCenter.position;

                Instantiate(shuffledPrefabs[spawned], spawnPos, Quaternion.identity);
                spawned++;
            }

            attempts++;
        }

        if (spawned < objectCount)
        {
            Debug.LogWarning("Could not place all objects with given constraints.");
        }
    }

    // Fisher–Yates Shuffle
    void Shuffle<T>(List<T> list)
    {
        for (int i = list.Count - 1; i > 0; i--)
        {
            int k = Random.Range(0, i + 1);
            T temp = list[i];
            list[i] = list[k];
            list[k] = temp;
        }
    }
}
