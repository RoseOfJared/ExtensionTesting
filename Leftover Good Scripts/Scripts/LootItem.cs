using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public enum LootQuality
{
    Common,
    Uncommon,
    Rare,
    Epic,
    Legendary
};

[CreateAssetMenu(fileName ="LootItem", menuName ="RPG Experiments/Loot Item")]
public class LootItem : ScriptableObject {
    public LootQuality quality;
    public new string name;
    [TextArea]
    public string acqText;
    [Space]
    public int weight;
    public float probabilityPercent;
    public int rangeFrom;
    public int rangeTo;

}
