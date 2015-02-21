from sae.const import MYSQL_HOST, MYSQL_HOST_S, MYSQL_PORT, MYSQL_USER, MYSQL_PASS, MYSQL_DB
from service.pool import Pool

MasterPool = Pool()
MasterConnector = MasterPool.get