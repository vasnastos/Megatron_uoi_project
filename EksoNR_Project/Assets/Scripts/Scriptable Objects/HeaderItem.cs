using Sirenix.OdinInspector;
using UnityEngine;

[CreateAssetMenu(fileName = "New Header Item")]
public class HeaderItem : ScriptableObject
{
    #region Const Variables
    private const float _previewFieldHeight = 100;
    private const float _labelWidth = 75;
    private const string _leftVerticalGroup = "Split/Left";
    private const string _rightVerticalGroup = "Split/Right";
    #endregion

    [HideLabel, Space(35), PreviewField(_previewFieldHeight, ObjectFieldAlignment.Left)]
    [HorizontalGroup("Split", 125)]
    [VerticalGroup(_leftVerticalGroup)]
    public Sprite Model;

    [PropertySpace(35f)]
    [Title("HEADER ITEM", "$Name", TitleAlignments.Centered, bold: true)]
    [VerticalGroup(_rightVerticalGroup)]
    [LabelWidth(_labelWidth)]
    public string Name;

    [VerticalGroup(_rightVerticalGroup)]
    [LabelWidth(_labelWidth)]
    public Sprite Sprite;

    private void OnValidate()
    {
        Model = Sprite;
    }
}
