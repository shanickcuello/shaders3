using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.SceneManagement;

public class LevelManager : MonoBehaviour
{
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.F7))
        {
            SceneManager.LoadScene("Demo_0_Player");
        }
        if (Input.GetKeyDown(KeyCode.F1)) 
        {
            SceneManager.LoadScene("Demo_1_IceSnow 1");
        }
        if (Input.GetKeyDown(KeyCode.F2))
        {
            SceneManager.LoadScene("Demo_2_teleport");
        }
        if (Input.GetKeyDown(KeyCode.F3))
        {
            SceneManager.LoadScene("Demo_2_Water 1");
        }
        if (Input.GetKeyDown(KeyCode.F4))
        {
            SceneManager.LoadScene("Demo_3_Fire");
        }
        if (Input.GetKeyDown(KeyCode.F5))
        {
            SceneManager.LoadScene("Demo_3_Portal");
        }
        if (Input.GetKeyDown(KeyCode.F6))
        {
            SceneManager.LoadScene("Demo_4_Pixel");
        }
    }
}
