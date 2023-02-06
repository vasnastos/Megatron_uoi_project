using Sirenix.OdinInspector;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;


[System.Serializable]
public class Item
{
    public float Pitch;
    public float Roll;
    public float RToe;
    public float RHeel;
    public float LToe;
    public float LHeel;
    public float RHipX;
    public float RHipY;
    public float LHipX;
    public float LHipY;
    public float State;
    public float FootState;

    public Item(float pitch, float roll, float rToe, float rHeel, float lToe, float lHeel, float rHipX, float rHipY, float lHipX, float lHipY, float state, float footState)
    {
        Pitch = pitch;
        Roll = roll;
        RToe = rToe;
        RHeel = rHeel;
        LToe = lToe;
        LHeel = lHeel;
        RHipX = rHipX;
        RHipY = rHipY;
        LHipX = lHipX;
        LHipY = lHipY;
        State = state;
        FootState = footState;
    }
}

public class DataHandler : MonoBehaviour
{
    [SerializeField] private GameObject _headerParent;
    [SerializeField] private GameObject _contentParent;

    [SerializeField] private List<HeaderItem> _headerItems;
    [SerializeField] private GameObject _bodyItemPrefab;

    [SerializeField] private List<Item> _items = new List<Item>();

    private float _startTime = 0f;

    private void Awake()
    {
        for (int i = 0; i < _headerParent.transform.childCount; i++)
        {
            SetHeader(i);
        }

        LoadItemData();
    }

    public void LoadItemData()
    {
        // Clear Database
        _items.Clear();

        _startTime = Time.realtimeSinceStartup;
        // Read CSV Files
        List<Dictionary<string, object>> data = CSVReader.Read("Dataset/ItemDatabase");
        print($"Elapsed Time: {Time.realtimeSinceStartup - _startTime}");
        for (int i = 0; i < data.Count; i++)
        {
            float pitch = float.Parse(data[i]["Pitch"].ToString());
            float roll = float.Parse(data[i]["Roll"].ToString());
            float rToe = float.Parse(data[i]["Rtoe"].ToString());
            float rHeel = float.Parse(data[i]["Rheel"].ToString());
            float lToe = float.Parse(data[i]["Ltoe"].ToString());
            float lHeel = float.Parse(data[i]["Lheel"].ToString());
            float rHipX = float.Parse(data[i]["RHipX"].ToString());
            float rHipY = float.Parse(data[i]["RhipY"].ToString());
            float lHipX = float.Parse(data[i]["LHipX"].ToString());
            float lHipY = float.Parse(data[i]["LHipY"].ToString());
            float state = float.Parse(data[i]["State"].ToString());
            float footState = float.Parse(data[i]["FootState"].ToString());

            AddItem(pitch, roll, rToe, rHeel, lToe, lHeel, rHipX, rHipY, lHipX, lHipY, state, footState);
        }

        LoadDataToTable();
        ResizeContentRect();

    }

    private void AddItem(float pitch, float roll, float rToe, float rHeel, float lToe, float lHeel, float rHipX, float rHipY, float lHipX, float lHipY, float state, float footState)
    {
        Item tempItem = new Item(pitch, roll, rToe, rHeel, lToe, lHeel, rHipX, rHipY, lHipX, lHipY, state, footState);
        _items.Add(tempItem);
    }

    private void LoadDataToTable()
    {
        for (int i = 0; i < _contentParent.transform.childCount; i++)
        {
            Destroy(_contentParent.transform.GetChild(i).gameObject);
        }

        for (int i = 0; i < 500; i++)
        {
            GameObject go = Instantiate(_bodyItemPrefab, _contentParent.transform) as GameObject;
            #region Set Data Values To Table
            go.transform.GetChild(0).GetComponentInChildren<TMPro.TextMeshProUGUI>().text = _items[i].Pitch.ToString();
            go.transform.GetChild(1).GetComponentInChildren<TMPro.TextMeshProUGUI>().text = _items[i].Roll.ToString();
            go.transform.GetChild(2).GetComponentInChildren<TMPro.TextMeshProUGUI>().text = _items[i].RToe.ToString();
            go.transform.GetChild(3).GetComponentInChildren<TMPro.TextMeshProUGUI>().text = _items[i].RHeel.ToString();
            go.transform.GetChild(4).GetComponentInChildren<TMPro.TextMeshProUGUI>().text = _items[i].LToe.ToString();
            go.transform.GetChild(5).GetComponentInChildren<TMPro.TextMeshProUGUI>().text = _items[i].LHeel.ToString();
            go.transform.GetChild(6).GetComponentInChildren<TMPro.TextMeshProUGUI>().text = _items[i].RHipX.ToString();
            go.transform.GetChild(7).GetComponentInChildren<TMPro.TextMeshProUGUI>().text = _items[i].RHipY.ToString();
            go.transform.GetChild(8).GetComponentInChildren<TMPro.TextMeshProUGUI>().text = _items[i].LHipX.ToString();
            go.transform.GetChild(9).GetComponentInChildren<TMPro.TextMeshProUGUI>().text = _items[i].LHipY.ToString();
            go.transform.GetChild(10).GetComponentInChildren<TMPro.TextMeshProUGUI>().text = _items[i].State.ToString();
            go.transform.GetChild(11).GetComponentInChildren<TMPro.TextMeshProUGUI>().text = _items[i].FootState.ToString();
            #endregion
        }
    }

    private void SetHeader(int index)
    {
        Transform child = _headerParent.transform.GetChild(index);

        child.GetChild(0).GetComponent<Image>().sprite = _headerItems[index].Sprite;
        child.GetChild(1).GetComponent<TMPro.TextMeshProUGUI>().text = _headerItems[index].Name;
    }

    #region Resize Content Rect
    private RectTransform _contentView;
    private VerticalLayoutGroup _verticalLayoutGroup;

    public void ResizeContentRect()
    {
        _contentView = _contentParent.GetComponent<RectTransform>();
        _verticalLayoutGroup = _contentParent.GetComponent<VerticalLayoutGroup>();

        float contentHeight = _verticalLayoutGroup.padding.top + _verticalLayoutGroup.padding.bottom;

        for (int i = 0; i < _contentParent.transform.childCount; i++)
        {
            contentHeight += 50 + _verticalLayoutGroup.spacing;
        }

        _contentView.SetInsetAndSizeFromParentEdge(RectTransform.Edge.Top, 0, contentHeight);
    }
    #endregion
}
