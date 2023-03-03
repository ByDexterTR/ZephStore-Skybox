#include <sourcemod>
#include <sdktools_stringtables>
#include <store>

#pragma semicolon 1
#pragma newdecls required

public Plugin myinfo = 
{
	name = "ZephStore - Skybox", 
	author = "ByDexter", 
	description = "", 
	version = "1.0", 
	url = "https://steamcommunity.com/id/ByDexterTR - ByDexter#5494"
};


ArrayList Skyboxes;
char defskybox[256];

public void OnPluginStart()
{
	Skyboxes = new ArrayList(256);
	
	Store_RegisterHandler("Skybox", "path", SkyboxOnMapStart, SkyboxReset, SkyboxConfig, SkyboxEquip, SkyboxRemove, true);
}

public void OnMapStart()
{
	SkyboxOnMapStart();
}

public void SkyboxOnMapStart()
{
	FindConVar("sv_skyname").GetString(defskybox, 256);
	
	char sPath[256];
	
	for (int i = 0; i < Skyboxes.Length; i++)
	{
		Skyboxes.GetString(i, sPath, 256);
		SkyboxAddFileToDownloadsTable(sPath);
	}
}

public void SkyboxReset()
{
	Skyboxes.Clear();
}

public bool SkyboxConfig(Handle &kv, int itemid)
{
	char sPath[256];
	KvGetString(kv, "path", sPath, 256);
	Store_SetDataIndex(itemid, Skyboxes.PushString(sPath));
	return true;
}

public int SkyboxEquip(int client, int itemid)
{
	int index = Store_GetDataIndex(itemid);
	char sPath[256];
	Skyboxes.GetString(index, sPath, 256);
	SendConVarValue(client, FindConVar("sv_skyname"), sPath);
	return 0;
}

public int SkyboxRemove(int client, int itemid)
{
	SendConVarValue(client, FindConVar("sv_skyname"), defskybox);
	return 0;
}

void SkyboxAddFileToDownloadsTable(const char[] filename)
{
	char buffer[256];
	static char rotfix[][] = { "bk", "Bk", "dn", "Dn", "ft", "Ft", "lf", "Lf", "rt", "Rt", "up", "Up",  };
	for (int i = 0; i < sizeof(rotfix); i++)
	{
		FormatEx(buffer, sizeof(buffer), "materials/skybox/%s%s.vtf", filename, rotfix[i]);
		if (FileExists(buffer, false))
			AddFileToDownloadsTable(buffer);
		
		FormatEx(buffer, sizeof(buffer), "materials/skybox/%s%s.vmt", filename, rotfix[i]);
		if (FileExists(buffer, false))
			AddFileToDownloadsTable(buffer);
	}
} 