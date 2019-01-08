using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEditor;

[CreateAssetMenu(fileName ="Loot Table", menuName = "RPG Experiments/New Loot Table")]
public class LootTable : ScriptableObject {

    public new string name;
    public LootItem[] lootItems;
    public float totalProbabilityWeight;

    public void InitTable()
    {
        int tempProbWeight = 0;

        //Calculate ranges of items
        foreach(LootItem item in lootItems)
        {
            item.rangeFrom = tempProbWeight;
            tempProbWeight += item.weight;
            item.rangeTo = tempProbWeight;
        }

        //Set the total weight to be equal to the temp weight
        totalProbabilityWeight = tempProbWeight;

        foreach(LootItem item in lootItems)
        {
            item.probabilityPercent = ((item.weight) / totalProbabilityWeight) * 100;
        }

    }

    //Resets the items inside of the LootTable
    public void ResetItems()
    {
        int size = lootItems.Length;
        lootItems = new LootItem[0];
        totalProbabilityWeight = 0;
    }
	
}

[CustomEditor(typeof(LootTable))]
public class LootTableEditor : Editor
{
    public override void OnInspectorGUI()
    {
        base.OnInspectorGUI();

        LootTable myScript = (LootTable)target;
        if(GUILayout.Button("Initialize Loot Table"))
        {
            myScript.InitTable();
        }

        if(GUILayout.Button("Reset Loot Items"))
        {
            myScript.ResetItems();
        }
    }
}
