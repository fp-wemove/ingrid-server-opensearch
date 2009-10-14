package de.ingrid.server.opensearch.index;

import java.io.File;
import java.sql.Connection;
import java.sql.DriverManager;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.quartz.JobExecutionContext;
import org.quartz.JobExecutionException;
import org.quartz.StatefulJob;

import de.ingrid.iplug.PlugServer;
import de.ingrid.iplug.dsc.index.AbstractSearcher;
import de.ingrid.iplug.dsc.index.DatabaseConnection;
import de.ingrid.iplug.dsc.schema.Construct;
import de.ingrid.iplug.dsc.schema.RecordReader;
import de.ingrid.utils.PlugDescription;

/**
 * Quarz job that runs the indexing
 */
public class IndexingJob implements StatefulJob {

    private static final long MINUTE = 1000 * 60;

    private static Log log = LogFactory.getLog(IndexingJob.class);

    public void execute(JobExecutionContext context) throws JobExecutionException {
        long startTime = System.currentTimeMillis();
        log.info("start indexing job...");
        try {
            Construct construct;
            PlugDescription plugDescription;
            try {
                plugDescription = PlugServer.getPlugDescription();
                construct = AbstractSearcher.getConstruct(plugDescription);
            } catch (Exception e) {
            	log.error(
						"exception while create plugdescription and construct",
						e);
                throw new JobExecutionException("unable to load the configuration values", e, false);
            }

            File file = plugDescription.getWorkinDirectory();
            DatabaseConnection dsConnection = (DatabaseConnection) plugDescription.getConnection();

            Class.forName(dsConnection.getDataBaseDriver());
            String url = dsConnection.getConnectionURL();
            String user = dsConnection.getUser();
            String password = dsConnection.getPassword();
            Connection connection = DriverManager.getConnection(url, user, password);

            RecordReader reader = new RecordReader(construct, connection, dsConnection.getSchema(), url, user, password);
            de.ingrid.iplug.dsc.index.Indexer indexer = null;

            while ((indexer = de.ingrid.iplug.dsc.index.Indexer.getInstance(file, reader)) == null) {
                log.warn("old indexing job still running, check your scheduler settings...");
                Thread.sleep(MINUTE);
            }

            try {
                indexer.index();
            } catch (Exception e) {
            	log.error("exception while indexing", e);
                throw e;
            } finally {
                indexer.close();
            }
        } catch (Exception e) {
        	log.error("exception while indexing job.", e);
            throw new JobExecutionException(e);
        }
        log.info("indexing job done in: " + (System.currentTimeMillis() - startTime) + " ms");
    }
}
