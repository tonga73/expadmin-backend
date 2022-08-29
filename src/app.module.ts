import { Module } from '@nestjs/common';
import { PrismaService } from './prisma.service';

import { AppController } from './app.controller';
import { AppService } from './app.service';

import { UserModule } from './user/user.module';

import { RecordModule } from './record/record.module';

import { LocationModule } from './location/location.module';

@Module({
  imports: [UserModule, LocationModule, RecordModule],
  controllers: [AppController],
  providers: [AppService, PrismaService],
})
export class AppModule {}
