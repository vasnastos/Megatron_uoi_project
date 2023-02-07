using Sirenix.OdinInspector;
using System.Collections.Generic;
using Unity.VisualScripting;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.XR;


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
    public float RHCur;
    public float RHAng;
    public float RKCur;
    public float RKAng;
    public float LHCur;
    public float LHAng;
    public float LKCur;
    public float LKAng;
    public float State;
    public float FootState;
    public float MinState;
    public float KeyState;
    public float WeightShift;
    public float HMI;
    public float RefTime;
    public float Thigh;
    public float Tlow;

    public Item(float pitch, float roll, float rToe, float rHeel, float lToe, float lHeel, float rHipX, float rHipY, float lHipX, float lHipY, float rHCur, float rHAng, float rKCur, float rKAng, float lHCur, float lHAng, float lKCur, float lKAng, float state, float footState, float minState, float keyState, float weightShift, float hMI, float refTime, float thigh, float tlow)
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
        RHCur = rHCur;
        RHAng = rHAng;
        RKCur = rKCur;
        RKAng = rKAng;
        LHCur = lHCur;
        LHAng = lHAng;
        LKCur = lKCur;
        LKAng = lKAng;
        State = state;
        FootState = footState;
        MinState = minState;
        KeyState = keyState;
        WeightShift = weightShift;
        HMI = hMI;
        RefTime = refTime;
        Thigh = thigh;
        Tlow = tlow;
    }
}

public class DataHandler : MonoBehaviour
{
    [SerializeField] private GameObject _headerContentParent;
    [SerializeField] private GameObject _bodyContentParent;

    [SerializeField] private List<HeaderItem> _headerItems;
    [SerializeField] private GameObject _bodyItemPrefab;

    [SerializeField] private List<Item> _items = new List<Item>();

    [SerializeField] private bool _loadAllItems;
    [SerializeField] private int _displayNumberOfItems;

    private float _startTime = 0f;

    private void Awake()
    {
        LoadHeaderData();
        LoadItemData();
        print($"Elapsed Time: {Time.realtimeSinceStartup - _startTime}");
    }

    private void OnValidate()
    {
        LoadHeaderData();
    }

    private void LoadHeaderData()
    {
        for (int i = 0; i < _headerContentParent.transform.childCount; i++)
        {
            SetHeader(i);
        }
    }

    public void LoadItemData()
    {
        // Clear Database
        _items.Clear();

        // Read CSV Files
        List<Dictionary<string, object>> data = CSVReader.Read("Dataset/ItemDatabase");

        for (int i = 0; i < data.Count; i++)
        {
            #region Store CSV Data Localy
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
            float rHCur = float.Parse(data[i]["RHCur"].ToString());
            float rHAng = float.Parse(data[i]["RHAng"].ToString());
            float rKCur = float.Parse(data[i]["RKCur"].ToString());
            float rKAng = float.Parse(data[i]["RKAng"].ToString());
            float lHCur = float.Parse(data[i]["LHCur"].ToString());
            float lHAng = float.Parse(data[i]["LHAng"].ToString());
            float lKCur = float.Parse(data[i]["LKCur"].ToString());
            float lKAng = float.Parse(data[i]["LKAng"].ToString());
            float footState = float.Parse(data[i]["FootState"].ToString());
            float minState = float.Parse(data[i]["MinState"].ToString());
            float keyState = float.Parse(data[i]["KeyState"].ToString());
            float weightShift = float.Parse(data[i]["WeightShift"].ToString());
            float hMI = float.Parse(data[i]["HMI"].ToString());
            float refTime = float.Parse(data[i]["RefTime"].ToString());
            float thigh = float.Parse(data[i]["Thigh"].ToString());
            float tlow = float.Parse(data[i]["Tlow"].ToString());
            #endregion

            AddItem(pitch, roll, rToe, rHeel, lToe, lHeel, rHipX, rHipY, lHipX, lHipY, rHCur, rHAng, rKCur, rKAng, lHCur, lHAng, lKCur, lKAng, state, footState, minState, keyState, weightShift, hMI, refTime, thigh, tlow);
        }
        _startTime = Time.realtimeSinceStartup;
        LoadDataToTable();
        ResizeContentRect();
    }

    public void OnHorizontalValueChanged(bool isHeader)
    {
        if(isHeader)
            _bodyContentParent.transform.parent.GetComponentInParent<ScrollRect>().horizontalNormalizedPosition = _headerContentParent.transform.parent.GetComponentInParent<ScrollRect>().horizontalNormalizedPosition;
        else
            _headerContentParent.transform.parent.GetComponentInParent<ScrollRect>().horizontalNormalizedPosition = _bodyContentParent.transform.parent.GetComponentInParent<ScrollRect>().horizontalNormalizedPosition;
    }

    private void AddItem(float pitch, float roll, float rToe, float rHeel, float lToe, float lHeel, float rHipX, float rHipY, float lHipX, float lHipY, float rHCur, float rHAng, float rKCur, float rKAng, float lHCur, float lHAng, float lKCur, float lKAng, float state, float footState, float minState, float keyState, float weightShift, float hMI, float refTime, float thigh, float tlow)
    {
        Item tempItem = new Item(pitch, roll, rToe, rHeel, lToe, lHeel, rHipX, rHipY, lHipX, lHipY, rHCur, rHAng, rKCur, rKAng, lHCur, lHAng, lKCur, lKAng, state, footState, minState, keyState, weightShift, hMI,refTime,thigh,tlow);
        _items.Add(tempItem);
    }

    private void LoadDataToTable()
    {
        for (int i = 0; i < _bodyContentParent.transform.childCount; i++)
        {
            Destroy(_bodyContentParent.transform.GetChild(i).gameObject);
        }

        if (_loadAllItems)
            _displayNumberOfItems = _items.Count;


        for (int i = 0; i < _displayNumberOfItems; i++)
        {
            GameObject go = Instantiate(_bodyItemPrefab, _bodyContentParent.transform) as GameObject;

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
            go.transform.GetChild(10).GetComponentInChildren<TMPro.TextMeshProUGUI>().text = _items[i].RHCur.ToString();
            go.transform.GetChild(11).GetComponentInChildren<TMPro.TextMeshProUGUI>().text = _items[i].RHAng.ToString();
            go.transform.GetChild(12).GetComponentInChildren<TMPro.TextMeshProUGUI>().text = _items[i].RKCur.ToString();
            go.transform.GetChild(13).GetComponentInChildren<TMPro.TextMeshProUGUI>().text = _items[i].RKAng.ToString();
            go.transform.GetChild(14).GetComponentInChildren<TMPro.TextMeshProUGUI>().text = _items[i].LHCur.ToString();
            go.transform.GetChild(15).GetComponentInChildren<TMPro.TextMeshProUGUI>().text = _items[i].LHAng.ToString();
            go.transform.GetChild(16).GetComponentInChildren<TMPro.TextMeshProUGUI>().text = _items[i].LKCur.ToString();
            go.transform.GetChild(17).GetComponentInChildren<TMPro.TextMeshProUGUI>().text = _items[i].LKAng.ToString();
            go.transform.GetChild(18).GetComponentInChildren<TMPro.TextMeshProUGUI>().text = _items[i].State.ToString();
            go.transform.GetChild(19).GetComponentInChildren<TMPro.TextMeshProUGUI>().text = _items[i].FootState.ToString();
            go.transform.GetChild(20).GetComponentInChildren<TMPro.TextMeshProUGUI>().text = _items[i].MinState.ToString();
            go.transform.GetChild(21).GetComponentInChildren<TMPro.TextMeshProUGUI>().text = _items[i].KeyState.ToString();
            go.transform.GetChild(22).GetComponentInChildren<TMPro.TextMeshProUGUI>().text = _items[i].WeightShift.ToString();
            go.transform.GetChild(23).GetComponentInChildren<TMPro.TextMeshProUGUI>().text = _items[i].HMI.ToString();
            go.transform.GetChild(24).GetComponentInChildren<TMPro.TextMeshProUGUI>().text = _items[i].RefTime.ToString();
            go.transform.GetChild(25).GetComponentInChildren<TMPro.TextMeshProUGUI>().text = _items[i].Thigh.ToString();
            go.transform.GetChild(26).GetComponentInChildren<TMPro.TextMeshProUGUI>().text = _items[i].Tlow.ToString();

            #endregion
        }
    }

    private void SetHeader(int index)
    {
        Transform child = _headerContentParent.transform.GetChild(index);

        child.GetChild(0).GetComponent<Image>().sprite = _headerItems[index].Sprite;
        child.GetChild(1).GetComponent<TMPro.TextMeshProUGUI>().text = _headerItems[index].Name;
    }

    #region Resize Content Rect
    private RectTransform _contentView;
    private VerticalLayoutGroup _verticalLayoutGroup;

    public void ResizeContentRect()
    {
        _contentView = _bodyContentParent.GetComponent<RectTransform>();
        _verticalLayoutGroup = _bodyContentParent.GetComponent<VerticalLayoutGroup>();

        float contentHeight = _verticalLayoutGroup.padding.top + _verticalLayoutGroup.padding.bottom;

        for (int i = 0; i < _bodyContentParent.transform.childCount; i++)
        {
            contentHeight += 50 + _verticalLayoutGroup.spacing;
        }

        _contentView.SetInsetAndSizeFromParentEdge(RectTransform.Edge.Top, 0, contentHeight);
    }
    #endregion
}
