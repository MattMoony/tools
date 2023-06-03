// https://stackoverflow.com/questions/5917304/how-do-i-detect-a-disabled-network-interface-connection-from-a-windows-applicati/5942359#5942359

#include <iostream>
#include <comdef.h>
#include <netcon.h>

int main()
{
    HRESULT hResult;

    typedef void(__stdcall* LPNcFreeNetconProperties)(NETCON_PROPERTIES* pProps);
    HMODULE hModule = LoadLibrary(L"netshell.dll");
    if (hModule == NULL) { return 1; }
    LPNcFreeNetconProperties NcFreeNetconProperties = (LPNcFreeNetconProperties)GetProcAddress(hModule, "NcFreeNetconProperties");

    hResult = CoInitializeEx(0, COINIT_MULTITHREADED);
    if (SUCCEEDED(hResult))
    {
        INetConnectionManager* pConnectionManager = 0;
        hResult = CoCreateInstance(CLSID_ConnectionManager, 0, CLSCTX_ALL, __uuidof(INetConnectionManager), (void**)&pConnectionManager);
        if (SUCCEEDED(hResult))
        {
            IEnumNetConnection* pEnumConnection = 0;
            hResult = pConnectionManager->EnumConnections(NCME_DEFAULT, &pEnumConnection);
            if (SUCCEEDED(hResult))
            {
                INetConnection* pConnection = 0;
                ULONG count;
                while (pEnumConnection->Next(1, &pConnection, &count) == S_OK)
                {
                    NETCON_PROPERTIES* pConnectionProperties = 0;
                    hResult = pConnection->GetProperties(&pConnectionProperties);
                    if (SUCCEEDED(hResult))
                    {
                        wprintf(L"Interface: %ls\n", pConnectionProperties->pszwName);
                        NcFreeNetconProperties(pConnectionProperties);
                    }
                    else
                        wprintf(L"[-] INetConnection::GetProperties() failed. Error code = 0x%08X (%ls)\n", hResult, _com_error(hResult).ErrorMessage());
                    pConnection->Release();
                }
                pEnumConnection->Release();
            }
            else
                wprintf(L"[-] IEnumNetConnection::EnumConnections() failed. Error code = 0x%08X (%ls)\n", hResult, _com_error(hResult).ErrorMessage());
            pConnectionManager->Release();
        }
        else
            wprintf(L"[-] CoCreateInstance() failed. Error code = 0x%08X (%ls)\n", hResult, _com_error(hResult).ErrorMessage());
        CoUninitialize();
    }
    else
        wprintf(L"[-] CoInitializeEx() failed. Error code = 0x%08X (%ls)\n", hResult, _com_error(hResult).ErrorMessage());

    FreeLibrary(hModule);
    wprintf(L"Done\n");
}
