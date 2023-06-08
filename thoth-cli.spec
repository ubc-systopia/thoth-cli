Summary: Thoth CLI service
Name: thoth-cli
Version: 0.0.0
Release: 1
License: #TODO
Source: %{expand:%%(pwd)}
BuildRoot: %{_topdir}/BUILD/%{name}-%{version}-%{release}

%description
%{summary}

%prep
rm -rf $RPM_BUILD_ROOT
mkdir -p $RPM_BUILD_ROOT/usr/bin
mkdir -p $RPM_BUILD_ROOT/var/thoth
cd $RPM_BUILD_ROOT
cp -f %{SOURCEURL0}/thoth ./usr/bin/thoth
%clean
rm -r -f "$RPM_BUILD_ROOT"

%files
%defattr(755,root,root)
/usr/bin/thoth
%dir /var/thoth